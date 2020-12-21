# typed: true
# frozen_string_literal: true

module RemoteEventHelper
  private

  def build_remote_event
    RemoteEvent.new(
      type: "event_type",
      metadata: {
        test_metadata: "test_metadata",
      }
    )
  end
end
