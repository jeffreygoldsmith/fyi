# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    class HandlerTest < ActiveSupport::TestCase
      include RemoteEventTestHelper

      class TestEventHandler < EventHandlers::BaseEventHandler
        extend(T::Sig)
        include RemoteEventTestHelper

        sig { override.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:) # rubocop:disable Lint/UnusedMethodArgument
          true
        end

        sig { override.params(event: T::Hash[Symbol, T.untyped]).returns(::Slack::RemoteEvent) }
        def parse(event:) # rubocop:disable Lint/UnusedMethodArgument
          build_remote_event
        end

        sig { override.params(remote_event: ::Slack::RemoteEvent).returns(T::Boolean) }
        def process(remote_event:) # rubocop:disable Lint/UnusedMethodArgument
          true
        end
      end

      setup do
        @event = raw_remote_event
        @remote_event = build_remote_event
        @slack_client = mock
        @event_handler = TestEventHandler.new(event_type: @remote_event.type)
        @handler = Handler.new(event: @event)
      end

      test "#handle delegates parsing and processing to the provided handler" do
        EventHandlers::Provider
          .expects(:provide_for)
          .with(has_entries(event_type: ::Slack::RemoteEvent::Type::Message))
          .returns(@event_handler)
        @handler.expects(:fyi_event?).returns(false)
        @event_handler.expects(:process)

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

      test "#handle skips processing if event was made by fyi and event handler wishes to ignore fyi events" do
        @event_handler.expects(:skip_fyi_events?).returns(true)
        @handler.expects(:fyi_event?).returns(true)
        @event_handler.expects(:process).never
        EventHandlers::Provider.expects(:provide_for).returns(@event_handler)

        @handler.handle
      end
    end
  end
end
