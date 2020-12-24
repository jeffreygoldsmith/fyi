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

        FYI_TRIGGER_REGEXP = T.let(/\?fyi (?<documentation>.+)/.freeze, Regexp)
        HOW_TRIGGER_REGEXP = T.let(/\?how (?<query>.+)/.freeze, Regexp)

        sig { override.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:)
          SUPPORTED_SLACK_EVENT_TYPES.include?(event_type)
        end

        sig { override.params(event: T::Hash[Symbol, T.untyped]).returns(::Slack::RemoteEvent) }
        def parse(event:)
          metadata = {
            text: event[:text],
            channel: event[:channel],
            timestamp: event[:ts],
          }

          ::Slack::RemoteEvent.new(
            type: @event_type,
            user_id: event[:user],
            metadata: metadata
          )
        end

        sig { override.params(remote_event: ::Slack::RemoteEvent).returns(T::Boolean) }
        def process(remote_event:)
          # Parse remote event metadata
          user_id = remote_event.user_id
          channel_id = remote_event.metadata[:channel]
          timestamp = remote_event.metadata[:timestamp]

          # Inspect message contents for trigger phrases
          fyi_trigger_result = FYI_TRIGGER_REGEXP.match(remote_event.metadata[:text])
          how_trigger_result = HOW_TRIGGER_REGEXP.match(remote_event.metadata[:text])

          # If the message contents trigger the ?fyi command, create a new Documentation.
          # Otherwise, if the message contents trigger the ?how command, query and list Documentation.
          if fyi_trigger_result
            documentation = T.must(fyi_trigger_result[:documentation])
            ::Responses::CreateDocumentation.new(
              text: documentation,
              user_id: user_id,
              channel_id: channel_id,
              timestamp: timestamp
            ).call
          elsif how_trigger_result
            query = T.must(how_trigger_result[:query])
            ::Responses::QueryDocumentation.new(
              query: query,
              channel_id: channel_id
            ).call
          end

          true
        end
      end
    end
  end
end
