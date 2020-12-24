# typed: true
# frozen_string_literal:true
module Slack
  class Client
    extend AccessibleFromThreadContext
    extend T::Sig

    sig { returns(::Slack::Web::Client) }
    attr_reader :client

    sig { void }
    def initialize
      @client = ::Slack::Web::Client.new
    end

    sig { params(user_id: String).returns(T.untyped) }
    def user_details(user_id:)
      user_info = @client.users_info(user: user_id)
      user_info.user
    end

    sig do
      params(
        channel_id: String,
        timestamp: String,
      ).returns(T::Hash[Symbol, T.untyped])
    end
    def message_details(
      channel_id:,
      timestamp:
    )
      @client.conversations_history(
        channel: channel_id,
        latest: timestamp,
        inclusive: true,
        limit: 1
      )[:messages].first
    end

    private

    def respond_to_missing?(method, *args)
      @client.respond_to?(method) || super
    end

    def method_missing(method, *args)
      if @client.respond_to?(method)
        @client.send(method, *args)
      else
        super
      end
    end
  end
end
