# typed: true
# frozen_string_literal: true

#
# Responses::QueryDocumentation
#
# Effect: find all documentation local to a given channel that matches the input query
#         and return it to the user in a formatted list sorted by most recent.
#
module Responses
  class QueryDocumentation
    extend(T::Sig)

    sig do
      params(
        query: String,
        channel_id: String,
      ).void
    end
    def initialize(
      query:,
      channel_id:
    )
      @query = query
      @channel_id = channel_id
    end

    sig { void }
    def call
      # Find all documentation local to a given channel that matches the input string.
      # Additionally, order results by most recent to prepare them to be displayed to the user.
      results = Documentation
        .where(slack_channel_id: @channel_id)
        .where("text LIKE (?)", "%#{@query}%")
        .order(created_at: :desc)
        .to_a

      # Send the formatted result to the user.
      # If there are no results, let them know.
      # Otherwise, give a formatted list of the documentation found through the above query.
      Slack::Client.current.chat_postMessage(
        channel: @channel_id,
        text: results.empty? ? "No documentation matches your search :(" : format_results(results),
        as_user: true
      )
    end

    private

    # Take in a list of documentation results, and output a string containing the formatted
    # documentation with additional user and channel information corresponding to each result.
    sig { params(results: T::Array[Documentation]).returns(String) }
    def format_results(results)
      result_string = "Most recent matching FYIs:\n".dup

      # Append each documentation, formatted and separated by a newline
      result_string + results.map do |documentation|
        # Fetch relevant documentation information from slack in order to format properly
        conversation_info = ::Slack::Client.current.conversations_info(channel: documentation.slack_channel_id)
        user_info = ::Slack::Client.current.users_info(user: documentation.slack_user_id)

        documentation.format(
          channel_name: conversation_info[:channel][:name],
          user_name: user_info[:user][:name]
        )
      end.join("\n")
    end
  end
end
