# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventHandlers
      class ReactionEventHandler < BaseEventHandler
        extend(T::Sig)

        SUPPORTED_SLACK_EVENT_TYPES = T.let(
          [
            ::Slack::RemoteEvent::Type::ReactionAdded,
            ::Slack::RemoteEvent::Type::ReactionRemoved,
          ].freeze,
          T::Array[::Slack::RemoteEvent::Type]
        )

        sig { override.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:)
          SUPPORTED_SLACK_EVENT_TYPES.include?(event_type)
        end

        sig { override.returns(::Slack::RemoteEvent) }
        def parse
          metadata = {
            reaction: @event[:reaction],
            message_channel: @event[:item][:channel],
            message_timestamp: @event[:item][:ts],
          }

          ::Slack::RemoteEvent.new(
            type: @event_type,
            user_id: @event[:user],
            metadata: metadata
          )
        end

        sig { override.returns(T::Boolean) }
        def process
        end
      end
    end
  end
end
