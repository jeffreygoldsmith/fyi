# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventParser
      class MessageEventHandlerTest < ActiveSupport::TestCase
        include RemoteEventHelper

        test "#accepts_event_type? returns true for the Message type" do
          assert_equal 1, MessageEventParser::SUPPORTED_SLACK_EVENT_TYPES.count

          accepted = MessageEventParser.accepts_event_type?(
            event_type: ::Slack::RemoteEvent::Type::Message
          )
          assert_equal true, accepted
        end

        test "#parse returns a remote event with the correct type and metadata" do
          event = raw_remote_event
          event_type = ::Slack::RemoteEvent::Type::Message
          message_event_parser = MessageEventParser.new(
            event: event,
            event_type: event_type
          )
          remote_event = message_event_parser.parse

          expected_metadata = {
            user: "U2147483697",
            text: "Hello world",
            channel: "C2147483705",
            timestamp: "1355517523.000005",
          }
          assert_equal event_type, remote_event.type
          assert_equal expected_metadata, remote_event.metadata
        end
      end
    end
  end
end
