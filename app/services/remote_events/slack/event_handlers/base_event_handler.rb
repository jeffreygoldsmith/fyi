# typed: true
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventHandlers
      class BaseEventHandler
        extend(T::Sig)
        extend(T::Helpers)
        abstract!

        sig do
          params(
            event: T::Hash[Symbol, T.untyped],
            event_type: ::Slack::RemoteEvent::Type,
            slack_client: ::Slack::Web::Client,
          ).void
        end
        def initialize(event:, event_type:, slack_client:)
          @event = event
          @event_type = event_type
          @slack_client = slack_client
        end

        sig { abstract.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:); end

        sig { abstract.returns(::Slack::RemoteEvent) }
        def parse; end

        sig { abstract.returns(T::Boolean) }
        def process; end

        sig { returns(T::Boolean) }
        def skip_fyi_events?
          true
        end
      end
    end
  end
end