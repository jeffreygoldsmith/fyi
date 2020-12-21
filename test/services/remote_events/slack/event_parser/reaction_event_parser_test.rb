# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventParser
      class ReactionEventParserTest < ActiveSupport::TestCase
        include RemoteEventHelper

        test "#accepts_event_type? returns true for the ReactionAdded and ReactionRemoved types" do
          assert_equal 2, ReactionEventParser::SUPPORTED_SLACK_EVENT_TYPES.count

          accepted = ReactionEventParser.accepts_event_type?(
            event_type: ::Slack::RemoteEvent::Type::ReactionAdded
          )
          assert_equal true, accepted

          accepted = ReactionEventParser.accepts_event_type?(
            event_type: ::Slack::RemoteEvent::Type::ReactionRemoved
          )
          assert_equal true, accepted
        end

        test "#parse returns a remote event with the correct type and metadata" do
          event = raw_reaction_event
          event_type = ::Slack::RemoteEvent::Type::ReactionAdded
          reaction_event_parser = ReactionEventParser.new(
            event: event,
            event_type: event_type
          )
          remote_event = reaction_event_parser.parse

          expected_metadata = {
            user: "U024BE7LH",
            reaction: "thumbsup",
            message_channel: "C0G9QF9GZ",
            message_timestamp: "1360782400.498405",
          }
          assert_equal event_type, remote_event.type
          assert_equal expected_metadata, remote_event.metadata
        end
      end
    end
  end
end
