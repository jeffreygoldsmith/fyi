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

  def raw_reaction_event
    {
      type: "reaction_added",
      user: "U024BE7LH",
      reaction: "thumbsup",
      item_user: "U0G9QF9C6",
      item: {
        type: "message",
        channel: "C0G9QF9GZ",
        ts: "1360782400.498405",
      },
      event_ts: "1360782804.083113",
    }
  end

  def build_remote_event
    ::Slack::RemoteEvent.new(
      type: ::Slack::RemoteEvent::Type::Message,
      user_id: "U2147483697",
      metadata: {
        test_metadata: "test_metadata",
      }
    )
  end
end
