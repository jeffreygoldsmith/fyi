# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    class HandlerTest < ActiveSupport::TestCase
      include RemoteEventHelper

      setup do
        @event = raw_remote_event
        @remote_event = build_remote_event
        @event_handler = mock
        @handler = Handler.new(event: @event)
      end

      test "#handle delegates parsing and processing to the provided handler" do
        @event_handler.expects(:parse).returns(@remote_event)
        @event_handler.expects(:process).returns(true)
        EventHandlers::Provider
          .expects(:provide_for)
          .with(
            event: @event,
            event_type: ::Slack::RemoteEvent::Type::Message
          )
          .returns(@event_handler)

        @handler.handle
      end

      test "#handle logs resulting remote event details" do
        @event_handler.expects(:parse).returns(@remote_event)
        @event_handler.expects(:process).returns(true)
        EventHandlers::Provider
          .expects(:provide_for)
          .with(
            event: @event,
            event_type: ::Slack::RemoteEvent::Type::Message
          )
          .returns(@event_handler)

        expected_fields = "type: \"#{@remote_event.type.serialize}\", metadata: \"#{@remote_event.metadata}\""
        expected_log = /.*Created remote event #{expected_fields}/
        assert_logs(:info, expected_log) do
          @handler.handle
        end
      end
    end
  end
end
