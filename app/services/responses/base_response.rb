# typed: true
# frozen_string_literal: true

#
# Responses::BaseResponse
#
# Effect: a base response for all other responses to inherit from.
#         A response should be a service which communicates with the user through Slack.
#         The goal of the BaseResponse is to execute a given responses individual functionality
#         and handle any errors that are raised during that process. Should an error be raised,
#         the BaseResponse should attempt to communicate that to the user if possible.
#
module Responses
  class BaseResponse
    extend(T::Sig)
    extend(T::Helpers)
    include Loggable
    abstract!

    sig { abstract.void }
    def respond; end

    sig { abstract.returns(String) }
    def channel_id; end

    sig { abstract.returns(String) }
    def timestamp; end

    sig { void }
    def call
      # Attempt to issue the given response
      # If an error occurs, attempt to react with an error emoji

      respond
    rescue => e
      fields = {
        response_type: self.class.name,
        error_message: e.message,
      }
      log_error("Failed to respond due to an error", fields: fields)

      # Attempt to respond with an error emoji
      Slack::Client.current.reactions_add(
        channel: @channel_id,
        name: Rails.application.config.fyi_error_emoji,
        timestamp: @timestamp,
      )
    end
  end
end
