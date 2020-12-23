# typed: false
# frozen_string_literal: true

require "test_helper"

module Slack
  class ClientTest < ActiveSupport::TestCase
    test "client delegates all methods to ruby-slack-client" do
      client = Client.new
      ::Slack::Web::Client.any_instance.expects(:test_method)
      client.test_method
    end

    test "client is accessible from thread context" do
      client = Client.new

      Client.with_current(client) do
        assert_equal client, Client.current
      end
    end
  end
end
