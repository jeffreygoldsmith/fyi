# typed: true
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventProcessor
      class BaseEventProcessor
        extend(T::Sig)
        extend(T::Helpers)
        abstract!

        sig { params(remote_event: ::Slack::RemoteEvent).void }
        def initialize(remote_event:)
          @remote_event = remote_event
        end

        sig { abstract.returns(T::Boolean) }
        def handle; end

        sig { abstract.params(event_type: String).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:); end

        def slack_client
          @slack_client ||= ::Slack::Web::Client.new
        end
      end
    end
  end
end
