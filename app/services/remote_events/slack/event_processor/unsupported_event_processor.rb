# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventProcessor
      class UnsupportedEventProcessor < BaseEventProcessor
        include Loggable
        extend(T::Sig)

        sig { override.returns(T::Boolean) }
        def process
          log_error("Attempted to process unsupported slack event")
          false
        end

        sig { override.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:) # rubocop:disable Lint/UnusedMethodArgument
          true
        end
      end
    end
  end
end
