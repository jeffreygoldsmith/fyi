# typed: false
# frozen_string_literal: true

require 'test_helper'

module Responses
  class BaseResponseTest < ActiveSupport::TestCase
    test "#call calls the respond method of the inheriting class" do
      documentation = build(:documentation)
      test_response = TestResponse.new(
        channel_id: documentation.slack_channel_id,
        timestamp: documentation.slack_timestamp
      )

      test_response.expects(:respond)

      test_response.call
    end

    test "#call logs that there was a failure to respond and adds a reaction if an error occurs" do
      documentation = build(:documentation)
      test_response = TestResponse.new(
        channel_id: documentation.slack_channel_id,
        timestamp: documentation.slack_timestamp
      )

      @mocked_slack_client = mock
      Slack::Client.expects(:current).returns(@mocked_slack_client).at_least_once
      test_response.expects(:respond).throws(:test)
      @mocked_slack_client
        .expects(:reactions_add)
        .with(has_entries(
          channel: documentation.slack_channel_id,
          name: "fyi-error",
          timestamp: documentation.slack_timestamp
        )).once

      expected_fields = "response_type: \"Responses::BaseResponseTest::TestResponse\", " \
        "error_message: \"uncaught throw :test\""
      expected_log = /.*Failed to respond due to an error #{expected_fields}/

      assert_logs(:error, expected_log) do
        test_response.call
      end
    end

    class TestResponse < BaseResponse
      extend(T::Sig)

      sig do
        params(
          channel_id: String,
          timestamp: String,
        ).void
      end
      def initialize(
        channel_id:,
        timestamp:
      )
        @channel_id = channel_id
        @timestamp = timestamp
      end

      sig { override.returns(String) }
      attr_reader :channel_id

      sig { override.returns(String) }
      attr_reader :timestamp

      sig { override.void }
      def respond
      end
    end
  end
end
