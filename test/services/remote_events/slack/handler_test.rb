# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    class HandlerTest < ActiveSupport::TestCase
      include RemoteEventHelper

      class TestEventHandler < EventHandlers::BaseEventHandler
        include RemoteEventHelper

        def self.accepts_event_type?(event_type:)
          true
        end

        def parse
          build_remote_event
        end

        def process
          true
        end
      end

      setup do
        @event = raw_remote_event
        @remote_event = build_remote_event
        @event_handler = TestEventHandler.new(
          event: @event,
          event_type: @remote_event.type,
          slack_client: ::Slack::Web::Client.new
        )
        @handler = Handler.new(event: @event)
      end

      test "#handle delegates parsing and processing to the provided handler" do
        EventHandlers::Provider
          .expects(:provide_for)
          .with(has_entries(
              event: @event,
              event_type: ::Slack::RemoteEvent::Type::Message,
              slack_client: instance_of(::Slack::Web::Client)
          ))
          .returns(@event_handler)
        @handler.expects(:fyi_event?).returns(true)


        @handler.handle
      end

      test "#handle logs resulting remote event details" do
        EventHandlers::Provider.expects(:provide_for).returns(@event_handler)
        @handler.expects(:fyi_event?).returns(false)

        expected_fields = "type: \"#{@remote_event.type.serialize}\", " \
          "user_id: \"#{@remote_event.user_id}\", " \
          "metadata: \"#{@remote_event.metadata}\""
        expected_log = /.*Handled a remote event #{expected_fields}/

        assert_logs(:info, expected_log) do
          @handler.handle
        end
      end

      test "#handle does not skip processing if event was made by fyi if not intended by event handler" do
        @event_handler.expects(:skip_fyi_events?).returns(false)
        @event_handler.expects(:process)
        EventHandlers::Provider.expects(:provide_for).returns(@event_handler)

        @handler.handle
      end

      test "#handle skips processing if event was made by fyi if intended by event handler" do
        @event_handler.expects(:process).never
        EventHandlers::Provider.expects(:provide_for).returns(@event_handler)
        @handler.expects(:fyi_event?).returns(true)

        @handler.handle
      end
    end
  end
end
