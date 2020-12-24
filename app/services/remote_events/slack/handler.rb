# typed: true
# frozen_string_literal: true
module RemoteEvents
  module Slack
    class Handler
      include Loggable
      extend(T::Sig)

      FYI_NAME = "fyi"

      sig { params(event: T::Hash[Symbol, T.untyped]).void }
      def initialize(event:)
        @event = event
        @event_type = ::Slack::RemoteEvent::Type.try_deserialize(event[:type]) || ::Slack::RemoteEvent::Type::Unknown
      end

      sig { void }
      def handle
        # Get correct handler from provider based on event type
        handler = RemoteEvents::Slack::EventHandlers::Provider.provide_for(event_type: @event_type)

        # Parse the raw remote event into an internal representation
        remote_event = handler.parse(event: @event)

        # If the event was created by FYI and the handler wishes to ignore it - return
        return if handler.skip_fyi_events? && fyi_event?(user_id: remote_event.user_id)

        # Process the remote event
        ::Slack::Client.with_current(slack_client) do
          handler.process(remote_event: remote_event)
        end

        # Log the event that was handled
        fields = {
          type: remote_event.type.serialize,
          user_id: remote_event.user_id,
          metadata: remote_event.metadata,
        }
        log_info("Handled a remote event", fields: fields)
      end

      private

      sig { params(user_id: String).returns(T::Boolean) }
      def fyi_event?(user_id:)
        user_details = slack_client.user_details(user_id: user_id)
        user_details.is_bot && user_details.name == FYI_NAME
      end

      sig { returns(::Slack::Client) }
      def slack_client
        @slack_client ||= ::Slack::Client.new
      end
    end
  end
end
