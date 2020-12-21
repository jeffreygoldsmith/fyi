# typed: true
# frozen_string_literal: true
module RemoteEvents
  module Slack
    class Parser
      include Loggable
      extend(T::Sig)

      sig { params(event: T::Hash[Symbol, T.untyped]).void }
      def initialize(event:)
        @event = event
        @event_type = ::Slack::RemoteEvent::Type.try_deserialize(event[:type]) || ::Slack::RemoteEvent::Type::Unknown
      end

      sig { returns(::Slack::RemoteEvent) }
      def parse
        remote_event = RemoteEvents::Slack::EventParser::Provider.provide_for(
          event: @event,
          event_type: @event_type
        ).parse

        fields = {
          type: remote_event.type.serialize,
          metadata: remote_event.metadata,
        }
        log_info("Created remote event", fields: fields)

        remote_event
      end
    end
  end
end
