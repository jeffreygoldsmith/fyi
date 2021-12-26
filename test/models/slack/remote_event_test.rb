# typed: false
# frozen_string_literal: true

require "test_helper"

module Slack
  class RemoteEventTest < ActiveSupport::TestCase
    test "#new creates a remote event with a type and metadata" do
      type = RemoteEvent::Type::Unknown
      user_id = "user_id"
      metadata = { test: "test" }

      remote_event = RemoteEvent.new(
        type: type,
        user_id: user_id,
        metadata: metadata
      )

      assert_equal remote_event.type, type
      assert_equal remote_event.user_id, user_id
      assert_equal remote_event.metadata, metadata
    end
  end
end
