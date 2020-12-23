# typed: true
# frozen_string_literal: true

#
# Responses::CreateDocumentation
#
# Effect: create a new Documentation and react with fyi-saved if successful
#
module Responses
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
      # Create a new documentation with the provided parameters
      Documentation.create(
        text: @text,
        slack_user_id: @user_id,
        slack_channel_id: @channel_id,
        slack_timestamp: @timestamp,
      )

      # Add the fyi-saved emoji to the documented message
      Slack::Client.current.reactions_add(
        channel: @channel_id,
        name: Rails.application.config.fyi_saved_emoji,
        timestamp: @timestamp,
      )
    end
  end
end
