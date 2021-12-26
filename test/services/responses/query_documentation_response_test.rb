# typed: false
# frozen_string_literal: true

require 'test_helper'

module Responses
  class QueryDocumentationResponseTest < ActiveSupport::TestCase
    setup do
      @channel_id = "test_channel_id"
      @expected_documentation = []
      @mocked_client = mock
      Slack::Client.expects(:current).returns(@mocked_client).at_least_once

      3.times do |i|
        travel_to(Time.utc(2020, 1, i + 1)) do
          @expected_documentation << create(
            :documentation,
            text: "test #{i}",
            slack_channel_id: @channel_id
          )
        end
      end
    end

    test "#call returns a list of formatted results to the user" do
      refuted_documentation = create(:documentation, text: "refuted")

      stub_formatting
      @mocked_client
        .expects(:chat_postMessage)
        .with do |args|
          @expected_documentation.each do |documentation|
            assert_match(/#{documentation.text}/, args[:text])
          end

          refute_match(/#{refuted_documentation.text}/, args[:text])
        end

      call_service(
        query: "test",
        channel_id: @channel_id
      )
    end

    test "#call returns a list of results sorted by most recent" do
      stub_formatting
      @mocked_client
        .expects(:chat_postMessage)
        .with do |args|
          sorted_result_regexp = /.*#{@expected_documentation.reverse.map(&:text).join("(.|\\s)*")}.*/
          assert_match sorted_result_regexp, args[:text]
        end

      call_service(
        query: "test",
        channel_id: @channel_id
      )
    end

    test "#call returns a 404 message if no results are found" do
      @mocked_client
        .expects(:chat_postMessage)
        .with do |args|
          assert_match(/No documentation matches your search :\(/, args[:text])
        end

      call_service(
        query: "no match",
        channel_id: @channel_id
      )
    end

    private

    def stub_formatting
      @mocked_client
        .expects(:conversations_info)
        .returns({
          channel: {
            name: "test channel name",
          },
        })
        .at_least_once

      @mocked_client
        .expects(:users_info)
        .returns({
          user: {
            name: "test user name",
          },
        })
        .at_least_once
    end

    def call_service(query:, channel_id:)
      QueryDocumentationResponse.new(
        query: query,
        channel_id: channel_id
      ).call
    end
  end
end
