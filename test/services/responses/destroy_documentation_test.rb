# typed: false
# frozen_string_literal: true

require 'test_helper'

module Responses
  class DestroyDocumentationTest < ActiveSupport::TestCase
    test "#call destroys provided documentation" do
      destroyed_documentation = create(:documentation)

      mocked_client = mock
      Slack::Client.expects(:current).returns(mocked_client)
      mocked_client.expects(:reactions_remove)

      assert_difference -> { Documentation.count }, -1 do
        call_service(
          channel_id: destroyed_documentation.slack_channel_id,
          timestamp: destroyed_documentation.slack_timestamp
        )
      end
    end

    test "#call removes fyi-saved reaction to the documentation message" do
      destroyed_documentation = create(:documentation)

      mocked_client = mock
      Slack::Client.expects(:current).returns(mocked_client)
      mocked_client.expects(:reactions_remove).with(
        channel: destroyed_documentation.slack_channel_id,
        name: Rails.application.config.fyi_saved_emoji,
        timestamp: destroyed_documentation.slack_timestamp
      )

      call_service(
        channel_id: destroyed_documentation.slack_channel_id,
        timestamp: destroyed_documentation.slack_timestamp
      )
    end

    private

    def call_service(
      channel_id:,
      timestamp:
    )
      DestroyDocumentation.new(
        channel_id: channel_id,
        timestamp: timestamp
      ).call
    end
  end
end
