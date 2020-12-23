# typed: true
# frozen_string_literal: true

class CreateDocumentation
  extend(T::Sig)

  sig do
    params(
      text: String,
      user_id: String,
      channel_id: String,
      timestamp: String,
    )
  end
  def initialize(
    text:,
    user_id:,
    channel_id:,
    timestamp:
  )
    @text = text
    @user_id = user_id
    @channel_id = channel_id
    @timestamp = timestamp
  end

  def call
    Documentation.create(
      text: @text,
      slack_user_id: @user_id,
      slack_channel_id: @channel_id,
      slack_timestamp: @timestamp,
    )

    slack_client.reactions_add(
      channel: channel_id,
      name: FYI_SAVED_EMOJI,
      timestamp: timestamp,
    )
  end
end