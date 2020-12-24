# typed: true
# frozen_string_literal: true

#
# Responses::DestroyDocumentation
#
# Effect: delete the provided documentation and remove the fyi-saved emoji from the given message
#
module Responses
  class DestroyDocumentation
    extend(T::Sig)

    sig do
      params(
        channel_id: String,
        timestamp: String,
      ).void
    end
    def initialize(
      channel_id:,
      timestamp:
    )
      @channel_id = channel_id
      @timestamp = timestamp
    end

    sig { void }
    def call
      # Find the documentation by timestamp
      documentation = Documentation.find_by(slack_timestamp: @timestamp)

      # If there is no corresponding documentation, return
      return if documentation.nil?

      # Destroy the documentation
      documentation.destroy!

      # Remove the fyi-saved emoji which was placed as a result of documentation creation
      Slack::Client.current.reactions_remove(
        channel: @channel_id,
        name: Rails.application.config.fyi_saved_emoji,
        timestamp: @timestamp,
      )
    end
  end
end
