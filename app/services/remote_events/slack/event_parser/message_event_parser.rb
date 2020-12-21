# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventParser
      class MessageEventParser < BaseEventParser
        extend(T::Sig)

        SUPPORTED_SLACK_EVENT_TYPES = T.let([
          ::Slack::RemoteEvent::Type::Message,
        ].freeze,
          T::Array[::Slack::RemoteEvent::Type])

        sig { override.returns(::Slack::RemoteEvent) }
        def parse
          metadata = {
            user: @event[:user],
            text: @event[:text],
            channel: @event[:channel],
            timestamp: @event[:ts],
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
