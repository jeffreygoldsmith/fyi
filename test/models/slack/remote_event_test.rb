# typed: false
# frozen_string_literal: true

require "test_helper"

module Slack
  class RemoteEventTest < ActiveSupport::TestCase
    test "#new creates a remote event with a type and metadata" do
      type = RemoteEvent::Type::Unknown
      metadata = { test: "test" }
      remote_event = RemoteEvent.new(type: type, metadata: metadata)
      assert_equal type, remote_event.type
      assert_equal metadata, remote_event.metadata
    end
  end
end
