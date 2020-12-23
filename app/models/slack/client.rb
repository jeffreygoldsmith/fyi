# typed: true
# frozen_string_literal:true
module Slack
  class Client
    extend AccessibleFromThreadContext
    extend T::Sig

    sig { void }
    def initialize
      @client = ::Slack::Web::Client.new
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

    def method_missing(method, *args)
      if @client.respond_to?(method)
        @client.send(method, *args)
      else
        super
      end
    end
  end
end
