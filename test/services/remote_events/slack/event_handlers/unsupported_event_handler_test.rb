# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventHandlers
      class UnsupportedEventHandlerTest < ActiveSupport::TestCase
        include RemoteEventTestHelper

        setup do
          @unsupported_event_handler = UnsupportedEventHandler.new(event_type: ::Slack::RemoteEvent::Type::Unknown)
        end

        test "#accepts_event_type? returns true for the unknown type" do
          accepted = UnsupportedEventHandler.accepts_event_type?(event_type: ::Slack::RemoteEvent::Type::Unknown)
          assert_equal true, accepted
        end

        test "#parse logs an error" do
          unknown_event = {
            type: "unknown",
          }

          expected_fields = "type: \"#{unknown_event[:type]}\""
          expected_log = /.*#parse Attempted to parse unsupported slack event #{expected_fields}/

          assert_logs(:error, expected_log) do
            parsed_event = @unsupported_event_handler.parse(event: unknown_event)

            assert_equal parsed_event.type, ::Slack::RemoteEvent::Type::Unknown
            assert_equal("", parsed_event.user_id)
            assert_equal({}, parsed_event.metadata)
          end
        end

        test "#process logs an error and returns false" do
          unknown_remote_event = ::Slack::RemoteEvent.new(type: ::Slack::RemoteEvent::Type::Unknown, user_id: "")

          expected_fields = "type: \"#{::Slack::RemoteEvent::Type::Unknown}\""
          expected_log = /.*#process Attempted to process unsupported slack event #{expected_fields}/

          assert_logs(:error, expected_log) do
            result = @unsupported_event_handler.process(remote_event: unknown_remote_event)

            assert_equal(false, result)
          end
        end
      end
    end
  end
end
