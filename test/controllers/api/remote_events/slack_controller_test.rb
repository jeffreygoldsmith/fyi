# typed: false
# frozen_string_literal: true
require 'test_helper'

module Api
  module RemoteEvents
    class SlackControllerTest < ActionDispatch::IntegrationTest
      test "#handle_event responds to url verification event correctly" do
        payload = {
          token: "Jhj5dZrVaK7ZwHHjRyZWjbDl",
          challenge: "3eZbrw1aBm2rZgRNFdxV2595E9CY3gmdALWMmHkvFXO7tYXAYM8P",
          type: "url_verification",
        }

        post '/api/remote_events/slack', params: payload

        expected_result = {
          "challenge" => payload[:challenge],
        }

        assert_equal expected_result, JSON.parse(response.body)
      end
    end
  end
end
