# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventProcessor
      class ProviderTest < ActiveSupport::TestCase
        include RemoteEventHelper

        class MockEventProcessor < BaseEventProcessor
          def self.accepts_event_type?(event_type:) # rubocop:disable Lint/UnusedMethodArgument
            true
          end
        end

        setup do
          @remote_event = build_remote_event
        end

        test "#provide_for returns the first processor which supports the event type" do
          mocked_event_processor = stub

          Provider.stubs(:supported_event_processors).returns([MockEventProcessor, mocked_event_processor])
          event_processor = Provider.provide_for(remote_event: @remote_event)

          assert_equal true, event_processor.is_a?(MockEventProcessor)
        end

        test "#provide_for returns instance of UnsupportedEventProcessor when no processors support the event type" do
          mocked_event_processor = stub

          mocked_event_processor.expects(:accepts_event_type?).with(event_type: @remote_event.type).returns(false)
          Provider.stubs(:supported_event_processors).returns([mocked_event_processor])
          event_processor = Provider.provide_for(remote_event: @remote_event)

          assert_equal true, event_processor.is_a?(UnsupportedEventProcessor)
        end
      end
    end
  end
end
