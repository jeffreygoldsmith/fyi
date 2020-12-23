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
    ).void
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

  sig { void }
  def call
    Documentation.create(
      text: @text,
      slack_user_id: @user_id,
      slack_channel_id: @channel_id,
      slack_timestamp: @timestamp,
    )

    Slack::Client.current.reactions_add(
      channel: @channel_id,
      name: Rails.application.config.fyi_saved_emoji,
      timestamp: @timestamp,
    )
  end
end
