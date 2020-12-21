# typed: true
# frozen_string_literal: true

module RemoteEventHelper
  private

  def raw_remote_event
    {
      type: "message",
      channel: "C2147483705",
      user: "U2147483697",
      text: "Hello world",
      ts: "1355517523.000005",
    }
  end

  def build_remote_event
    ::Slack::RemoteEvent.new(
      type: ::Slack::RemoteEvent::Type::Message,
      metadata: {
        test_metadata: "test_metadata",
      }
    )
  end
end
