# typed: true
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventParser
      class BaseEventParser
        extend(T::Sig)
        extend(T::Helpers)
        abstract!

        sig do
          params(
            event: T::Hash[Symbol, T.untyped],
            event_type: ::Slack::RemoteEvent::Type,
          ).void
        end
        def initialize(event:, event_type:)
          @event = event
          @event_type = event_type
        end

        sig { abstract.returns(::Slack::RemoteEvent) }
        def parse; end

        sig { abstract.params(event_type: ::Slack::RemoteEvent::Type).returns(T::Boolean) }
        def self.accepts_event_type?(event_type:); end
      end
    end
  end
end
