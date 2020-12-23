# typed: false
# frozen_string_literal: true

require 'test_helper'

class CreateDocumentationTest < ActiveSupport::TestCase
  test "#call persists a new documentation with the correct details" do
    expected_documentation = build(:documentation)

    mocked_client = mock
    Slack::Client.expects(:current).returns(mocked_client)
    mocked_client.expects(:reactions_add)

    assert_difference -> { Documentation.count }, 1 do
      call_service(
        text: expected_documentation.text,
        user_id: expected_documentation.slack_user_id,
        channel_id: expected_documentation.slack_channel_id,
        timestamp: expected_documentation.slack_timestamp
      )
    end

    documentation = Documentation.first

    assert_equal expected_documentation.text, documentation.text
    assert_equal expected_documentation.slack_user_id, documentation.slack_user_id
    assert_equal expected_documentation.slack_channel_id, documentation.slack_channel_id
    assert_equal expected_documentation.slack_timestamp, documentation.slack_timestamp
  end

  test "#call reacts to the documentation message with the fyi saved emoji" do
    expected_documentation = build(:documentation)

    mocked_client = mock
    Slack::Client.expects(:current).returns(mocked_client)
    mocked_client.expects(:reactions_add).with(
      channel: expected_documentation.slack_channel_id,
      name: Rails.application.config.fyi_saved_emoji,
      timestamp: expected_documentation.slack_timestamp
    )

    call_service(
      text: expected_documentation.text,
      user_id: expected_documentation.slack_user_id,
      channel_id: expected_documentation.slack_channel_id,
      timestamp: expected_documentation.slack_timestamp
    )
  end

  private

  def call_service(
    text:,
    user_id:,
    channel_id:,
    timestamp:
  )
    CreateDocumentation.new(
      text: text,
      user_id: user_id,
      channel_id: channel_id,
      timestamp: timestamp
    ).call
  end
end
