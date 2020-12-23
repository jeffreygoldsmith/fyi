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
