# frozen_string_literal: true
module LoggerAssertions
  class MockLogger < ::Logger
    Message = Struct.new(:level, :message) do
      alias_method(:to_s, :message)
    end

    attr_reader :messages

    def initialize
      super('/dev/null')
      @messages = []
    end

    def add(level, message = nil, progname = nil)
      if message.nil?
        if block_given?
          message = yield
        elsif progname
          message = progname
        end
      end
      @messages << Message.new(level, message)
    end

    def self.assert_called(level, messages, namespace, times: nil, &block)
      if level.is_a?(Symbol) || level.is_a?(String)
        level = Logger::Severity.const_get(level.to_s.upcase)
      end

      mock_logger = LoggerAssertions::MockLogger.new
      original_logger = namespace.logger
      namespace.logger = mock_logger
      namespace.logger.level = original_logger.level

      block.call

      Array(messages).each do |message|
        count = mock_logger.messages.count { |m| level == m[0] && message === m[1] } # rubocop:disable Style/CaseEquality
        if times.nil? && count == 0
          raise MiniTest::Assertion, mock_logger.error_message(level, message)
        elsif times.present? && count != times
          messages = mock_logger.messages.select { |m| m.level == level }.join("\n")
          raise MiniTest::Assertion, "The amount of log messages was unexpected." \
          " Expected #{times}, found #{count}:\n#{messages}"
        end
      end

      if original_logger.is_a?(self)
        mock_logger.messages.each do |m|
          original_logger.add(m.level, nil, m.message)
        end
      end
    ensure
      namespace.logger = original_logger
    end

    def error_message(level, message)
      error_message = []
      error_message << 'Expected log message did not occur:'
      error_message << "  #{log_level_to_string(level)}: #{message}"
      error_message << 'Did not match any of the following:'
      if messages.present?
        messages.each do |m|
          error_message << "  #{log_level_to_string(m.level)}: #{m.message}"
        end
      else
        error_message << '  No logs registered'
      end

      error_message.join("\n")
    end

    private

    def log_level_to_string(level)
      Rails.logger.send(:format_severity, level)
    end
  end

  def assert_logs(level, messages, namespace = Rails, times: nil, &block)
    LoggerAssertions::MockLogger.assert_called(level, messages, namespace, times: times, &block)
  end

  def assert_no_logs(level, messages = /./, namespace = Rails, &block)
    LoggerAssertions::MockLogger.assert_called(level, messages, namespace, times: 0, &block)
  end
end
