# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    class ProcessorTest < ActiveSupport::TestCase
      include RemoteEventHelper

      setup do
        @remote_event = build_remote_event
        @event_processor = mock
        @processor = Processor.new(remote_event: @remote_event)
      end

      test "#process delegates to processing provider" do
        @event_processor.expects(:process).returns(true)
        EventProcessor::Provider
          .expects(:provide_for)
          .with(remote_event: @remote_event)
          .returns(@event_processor)

        @processor.process
      end
    end
  end
end
