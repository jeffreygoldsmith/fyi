# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventHandlers
      class ProviderTest < ActiveSupport::TestCase
        include RemoteEventTestHelper

        class MockEventHandler < BaseEventHandler
          def self.accepts_event_type?(event_type:) # rubocop:disable Lint/UnusedMethodArgument
            true
          end
        end

        setup do
          @event_type = ::Slack::RemoteEvent::Type::Message
        end

        test "#provide_for returns the first handler which supports the event type" do
          mocked_event_handler = stub

          Provider.stubs(:supported_event_handlers).returns([MockEventHandler, mocked_event_handler])
          event_handler = Provider.provide_for(event_type: @event_type)

          assert_equal true, event_handler.is_a?(MockEventHandler)
        end

        test "#provide_for returns instance of UnsupportedEventHandler when no handlers support the event type" do
          mocked_event_handler = stub

          mocked_event_handler.expects(:accepts_event_type?).with(event_type: @event_type).returns(false)
          Provider.stubs(:supported_event_handlers).returns([mocked_event_handler])
          event_handler = Provider.provide_for(event_type: @event_type)

          assert_equal true, event_handler.is_a?(UnsupportedEventHandler)
        end
      end
    end
  end
end
