# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventParser
      class ProviderTest < ActiveSupport::TestCase
        include RemoteEventHelper

        class MockEventParser < BaseEventParser
          def self.accepts_event_type?(event_type:) # rubocop:disable Lint/UnusedMethodArgument
            true
          end
        end

        setup do
          @event = raw_remote_event
          @event_type = ::Slack::RemoteEvent::Type::Message
        end

        test "#provide_for returns the first parser which supports the event type" do
          mocked_event_parser = stub

          Provider.stubs(:supported_event_parsers).returns([MockEventParser, mocked_event_parser])
          event_parser = Provider.provide_for(event: @event, event_type: @event_type)

          assert_equal true, event_parser.is_a?(MockEventParser)
        end

        test "#provide_for returns instance of UnsupportedEventProcessor when no processors support the event type" do
          mocked_event_parser = stub

          mocked_event_parser.expects(:accepts_event_type?).with(event_type: @event_type).returns(false)
          Provider.stubs(:supported_event_parsers).returns([mocked_event_parser])
          event_parser = Provider.provide_for(event: @event, event_type: @event_type)

          assert_equal true, event_parser.is_a?(UnsupportedEventParser)
        end
      end
    end
  end
end
