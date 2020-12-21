# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventParser
      class ReactionEventParser < BaseEventParser
        extend(T::Sig)

        SUPPORTED_SLACK_EVENT_TYPES = T.let([
          ::Slack::RemoteEvent::Type::ReactionAdded,
          ::Slack::RemoteEvent::Type::ReactionRemoved,
        ].freeze,
          T::Array[::Slack::RemoteEvent::Type])

        sig { override.returns(::Slack::RemoteEvent) }
        def parse
          metadata = {
            user: @event[:user],
            reaction: @event[:reaction],
            message_channel: @event[:item][:channel],
            message_timestamp: @event[:item][:ts],
          }

          ::Slack::RemoteEvent.new(type: @event_type, metadata: metadata)
        end

        sig { override.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:)
          SUPPORTED_SLACK_EVENT_TYPES.include?(event_type)
        end
      end
    end
  end
end
