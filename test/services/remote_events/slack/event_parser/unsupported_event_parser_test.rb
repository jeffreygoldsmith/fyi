# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventParser
      class UnsupportedEventHandlerTest < ActiveSupport::TestCase
        test "#accepts_event_type? always returns true" do
          accepted = UnsupportedEventParser.accepts_event_type?(
            event_type: ::Slack::RemoteEvent::Type::Unknown
          )
          assert_equal true, accepted
        end

        test "#parse logs an error with the raw event type" do
          unsupported_event_parser = UnsupportedEventParser.new(
            event: {
              type: "unknown_type",
            },
            event_type: ::Slack::RemoteEvent::Type::Unknown
          )

          assert_logs(:error, /Attempted to parse unsupported slack event type: "unknown_type"/) do
            unsupported_event_parser.parse
          end
        end
      end
    end
  end
end
