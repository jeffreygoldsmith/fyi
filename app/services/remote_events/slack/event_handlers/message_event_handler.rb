# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventHandlers
      class MessageEventHandler < BaseEventHandler
        extend(T::Sig)

        SUPPORTED_SLACK_EVENT_TYPES = T.let(
          [
            ::Slack::RemoteEvent::Type::Message,
          ].freeze,
          T::Array[::Slack::RemoteEvent::Type]
        )

        FYI_TRIGGER_REGEXP = /\?fyi (?<documentation>.*)/
        HOW_TRIGGER_REGEXP = /\?how (?<query>.*)/

        sig { override.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:)
          SUPPORTED_SLACK_EVENT_TYPES.include?(event_type)
        end

        sig { override.returns(::Slack::RemoteEvent) }
        def parse
          metadata = {
            text: @event[:text],
            channel: @event[:channel],
            timestamp: @event[:ts],
          }

          ::Slack::RemoteEvent.new(
            type: @event_type,
            user_id: @event[:user],
            metadata: metadata
          )
        end

        sig { override.returns(T::Boolean) }
        def process
          user_id = @remote_event.metadata[:user]
          channel_id = @remote_event.metadata[:channel]
          timestamp = @remote_event.metadata[:timestamp]

          fyi_trigger_result = FYI_TRIGGER_REGEXP.match(@remote_event.metadata[:text])
          how_trigger_result = HOW_TRIGGER_REGEXP.match(@remote_event.metadata[:text])

          if fyi_trigger_result
            ::Responses::CreateDocumentation.new(
              text: fyi_trigger_result[:documentation],
              user_id: user_id,
              channel_id: channel_id,
              timestamp: timestamp
            ).call
          elsif how_trigger_result
            ::Responses::QueryDocumentation.new(
              query: how_trigger_result[:query],
              channel_id: channel_id
            ).call
          end

          true
        end
      end
    end
  end
end
