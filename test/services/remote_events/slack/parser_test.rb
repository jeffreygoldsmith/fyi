# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    class ParserTest < ActiveSupport::TestCase
      include RemoteEventHelper

      setup do
        @event = raw_remote_event
        @remote_event = build_remote_event
        @event_parser = mock
        @parser = Parser.new(event: @event)
      end

      test "#parse delegates to parsing provider" do
        @event_parser.expects(:parse).returns(@remote_event)
        EventParser::Provider
          .expects(:provide_for)
          .with(
            event: @event,
            event_type: ::Slack::RemoteEvent::Type::Message
          )
          .returns(@event_parser)

        @parser.parse
      end

      test "#parse returns delegated parsing result" do
        @event_parser.expects(:parse).returns(@remote_event)
        EventParser::Provider
          .expects(:provide_for)
          .with(
            event: @event,
            event_type: ::Slack::RemoteEvent::Type::Message
          )
          .returns(@event_parser)

        assert_equal(@remote_event, @parser.parse)
      end

      test "#parse logs resulting remote event details" do
        @event_parser.expects(:parse).returns(@remote_event)
        EventParser::Provider
          .expects(:provide_for)
          .with(
            event: @event,
            event_type: ::Slack::RemoteEvent::Type::Message
          )
          .returns(@event_parser)

        expected_fields = "type: \"#{@remote_event.type.serialize}\", metadata: \"#{@remote_event.metadata}\""
        expected_log = /.*Created remote event #{expected_fields}/
        assert_logs(:info, expected_log) do
          @parser.parse
        end
      end
    end
  end
end
