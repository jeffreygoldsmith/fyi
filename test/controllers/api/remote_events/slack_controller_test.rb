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

        SlackController.any_instance.expects(:verify_token)
        post api_remote_events_slack_path, params: payload

        assert_equal payload[:challenge], response.body
      end
    end
  end
end
