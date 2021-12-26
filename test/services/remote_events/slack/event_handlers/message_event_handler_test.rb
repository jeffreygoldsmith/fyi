# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventHandlers
      class MessageEventHandlerTest < ActiveSupport::TestCase
        include RemoteEventTestHelper

        test "#accepts_event_type? returns true for the Message type" do
          assert_equal 1, MessageEventHandler::SUPPORTED_SLACK_EVENT_TYPES.count

          accepted = MessageEventHandler.accepts_event_type?(
            event_type: ::Slack::RemoteEvent::Type::Message
          )
          assert_equal true, accepted
        end

        test "#parse returns a remote event with the correct type and metadata" do
          event = raw_remote_event
          event_type = ::Slack::RemoteEvent::Type::Message
          message_event_handler = MessageEventHandler.new(event_type: event_type)
          remote_event = message_event_handler.parse(event: event)

          expected_user_id = event[:user]
          expected_metadata = {
            text: event[:text],
            channel: event[:channel],
            timestamp: event[:ts],
          }

          assert_equal event_type, remote_event.type
          assert_equal expected_user_id, remote_event.user_id
          assert_equal expected_metadata, remote_event.metadata
        end
      end
    end
  end
end
