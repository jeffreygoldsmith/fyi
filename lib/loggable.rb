# typed: true
# frozen_string_literal: true
module Loggable
  extend ActiveSupport::Concern

  SEVERITIES = Logger::Severity.constants.map(&:downcase).freeze

  included do
    SEVERITIES.each do |severity|
      method_name = :"log_#{severity}"
      define_method method_name do |message, fields: {}, caller_offset: 0|
        caller_location = T.must(T.must(caller_locations)[caller_offset]).base_label
        T.unsafe(self.class).emit_log(severity, message, fields, caller_location)
      end
    end

    private_class_method :format_log
  end

  class_methods do
    SEVERITIES.each do |severity|
      method_name = :"log_#{severity}"
      define_method method_name do |message, fields: {}, caller_offset: 0|
        caller_location = T.must(T.must(caller_locations)[caller_offset]).base_label
        T.unsafe(self).emit_log(severity, message, fields, caller_location)
      end
    end

    def emit_log(severity, message, fields, caller_location)
      full_message = format_log(message, fields, caller_location)

      Kernel.puts full_message if severity == :debug
      Rails.logger.public_send(severity, full_message)
    end

    def format_log(message, fields, caller_location)
      fields = ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters).filter(fields)

      fields_string = fields.map { |key, value| "#{key}: \"#{value}\"" }.join(', ')

      "[#{self}]##{caller_location} #{message} #{fields_string}".strip
    end
  end
end
