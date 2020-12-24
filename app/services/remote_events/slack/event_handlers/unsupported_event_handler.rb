# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventHandlers
      class UnsupportedEventHandler < BaseEventHandler
        include Loggable
        extend(T::Sig)

        sig { override.params(event: T::Hash[Symbol, T.untyped]).returns(::Slack::RemoteEvent) }
        def parse(event:)
          log_error("Attempted to parse unsupported slack event", fields: { type: event[:type] })
          ::Slack::RemoteEvent.new(type: @event_type, user_id: "")
        end

        sig { override.params(remote_event: ::Slack::RemoteEvent).returns(T::Boolean) }
        def process(remote_event:)
          log_error("Attempted to process unsupported slack event", fields: { type: remote_event.type })
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
