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
            event_type: ::Slack::RemoteEvent::Type,
          ).void
        end
        def initialize(event_type:)
          @event_type = event_type
        end

        sig { abstract.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:); end

        sig { abstract.params(event: T::Hash[Symbol, T.untyped]).returns(::Slack::RemoteEvent) }
        def parse(event:); end

        sig { abstract.params(remote_event: ::Slack::RemoteEvent).returns(T::Boolean) }
        def process(remote_event:); end

        sig { returns(T::Boolean) }
        def skip_fyi_events?
          true
        end
      end
    end
  end
end
