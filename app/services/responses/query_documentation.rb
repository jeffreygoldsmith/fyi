# typed: true
# frozen_string_literal: true

module Responses
  class CreateDocumentation
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
      results = Documentation
        .where(slack_channel_id: channel_id)
        .where("text LIKE (?)", "%#{query}%")
        .order(updated_at: :desc)

      Slack::Client.current.chat_postMessage(
        channel: channel_id,
        text: results.empty? "No documentation matches your search :(" : format_results(results),
        as_user: true
      )
    end

    private

    def format_results(results)
      result_string = "Most recent matching FYIs:\n".dup
      result_string += results.map do |documentation|
        conversation_info = Slack::Client.conversations_info(channel: documentation.slack_channel_id)
        user_info = Slack::Client.users_info(user: documentation.slack_user_id)

        documentation.format(
          channel_name: conversation_info[:channel][:name],
          user_name: user_info[:user][:name]
        )
      end.join("\n")
    end
  end
end
