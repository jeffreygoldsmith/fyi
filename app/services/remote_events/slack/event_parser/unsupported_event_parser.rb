# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventParser
      class UnsupportedEventParser < BaseEventParser
        include Loggable
        extend(T::Sig)

        sig { override.returns(::Slack::RemoteEvent) }
        def parse
          Rails.logger.error("Attempted to parse unsupported slack event: #{@event_type}")
          ::Slack::RemoteEvent.new(type: @event_type)
        end

        sig { override.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:) # rubocop:disable Lint/UnusedMethodArgument
          true
        end
      end
    end
  end
end