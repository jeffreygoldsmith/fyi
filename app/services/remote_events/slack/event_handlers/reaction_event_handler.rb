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

        sig { override.params(event: T::Hash[Symbol, T.untyped]).returns(::Slack::RemoteEvent) }
        def parse(event:)
          metadata = {
            reaction: event[:reaction],
            message_channel: event[:item][:channel],
            message_timestamp: event[:item][:ts],
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
          reaction = remote_event.metadata[:reaction]
          message_channel = remote_event.metadata[:message_channel]
          message_timestamp = remote_event.metadata[:message_timestamp]

          # If the reaction is anything other than the FYI emoji we have no work to do
          return true unless reaction == Rails.application.config.fyi_emoji

          # Get message details in order to create/destroy Documentation
          message = ::Slack::Client.current.message_details(
            channel_id: message_channel,
            timestamp: message_timestamp
          )

          # If the FYI emoji was added to a message, create new Documentation.
          # Otherwise, delete the existing documentation corresponding to the reacted message.
          if @event_type == ::Slack::RemoteEvent::Type::ReactionAdded
            ::Responses::CreateDocumentationResponse.new(
              text: message[:text],
              user_id: message[:user],
              channel_id: message_channel,
              timestamp: message_timestamp
            ).call
          elsif @event_type == ::Slack::RemoteEvent::Type::ReactionRemoved
            ::Responses::DestroyDocumentationResponse.new(
              channel_id: message_channel,
              timestamp: message_timestamp
            ).call
          end

          true
        end
      end
    end
  end
end
