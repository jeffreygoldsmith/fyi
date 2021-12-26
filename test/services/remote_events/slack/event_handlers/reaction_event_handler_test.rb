# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventHandlers
      class ReactionEventHandlerTest < ActiveSupport::TestCase
        include RemoteEventTestHelper

        test "#accepts_event_type? returns true for the ReactionAdded and ReactionRemoved types" do
          assert_equal 2, ReactionEventHandler::SUPPORTED_SLACK_EVENT_TYPES.count

          accepted = ReactionEventHandler.accepts_event_type?(
            event_type: ::Slack::RemoteEvent::Type::ReactionAdded
          )
          assert_equal true, accepted

          accepted = ReactionEventHandler.accepts_event_type?(
            event_type: ::Slack::RemoteEvent::Type::ReactionRemoved
          )
          assert_equal true, accepted
        end

        test "#parse returns a remote event with the correct type and metadata" do
          event = raw_reaction_event
          event_type = ::Slack::RemoteEvent::Type::ReactionAdded
          reaction_event_handler = ReactionEventHandler.new(event_type: event_type)
          remote_event = reaction_event_handler.parse(event: event)

          expected_user_id = event[:user]
          expected_metadata = {
            reaction: event[:reaction],
            message_channel: event[:item][:channel],
            message_timestamp: event[:item][:ts],
          }

          assert_equal event_type, remote_event.type
          assert_equal expected_user_id, remote_event.user_id
          assert_equal expected_metadata, remote_event.metadata
        end
      end
    end
  end
end
