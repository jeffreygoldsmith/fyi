# typed: false
# frozen_string_literal: true

require 'test_helper'

module RemoteEvents
  module Slack
    module EventProcessor
      class UnsupportedEventProcessorTest < ActiveSupport::TestCase
        include RemoteEventHelper

        test "#accepts_event_type? always returns true" do
          accepted = UnsupportedEventProcessor.accepts_event_type?(
            event_type: ::Slack::RemoteEvent::Type::Unknown
          )
          assert_equal true, accepted
        end

        test "#parse logs an error with the raw event type" do
          unsupported_event_parser = UnsupportedEventProcessor.new(
            remote_event: build_remote_event
          )

          assert_logs(:error, /Attempted to process unsupported slack event/) do
            unsupported_event_parser.process
          end
        end
      end
    end
  end
end
