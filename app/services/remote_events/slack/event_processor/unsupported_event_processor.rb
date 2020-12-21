# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventProcessor
      class UnsupportedEventProcessor < BaseEventProcessor
        extend(T::Sig)

        sig { override.returns(T::Boolean) }
        def process
          Rails.logger.error("Received unsupported slack event: #{@remote_event.type}")
          false
        end

        sig { override.params(event_type: String).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:) # rubocop:disable Lint/UnusedMethodArgument
          true
        end
      end
    end
  end
end
