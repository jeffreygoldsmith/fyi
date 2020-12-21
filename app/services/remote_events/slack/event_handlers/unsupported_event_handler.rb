# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventHandlers
      class UnsupportedEventHandler < BaseEventHandler
        include Loggable
        extend(T::Sig)

        sig { override.returns(::Slack::RemoteEvent) }
        def parse
          log_error("Attempted to handle unsupported slack event", fields: { type: @event[:type] })
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
