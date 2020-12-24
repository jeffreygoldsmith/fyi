# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventHandlers
      class Provider
        class << self
          extend(T::Sig)

          sig { params(event_type: ::Slack::RemoteEvent::Type).returns(BaseEventHandler) }
          def provide_for(event_type:)
            T.must(
              handlers.detect do |handler|
                handler.accepts_event_type?(event_type: event_type)
              end
            ).new(event_type: event_type)
          end

          private

          sig { returns(T::Array[T.class_of(BaseEventHandler)]) }
          def handlers
            supported_event_handlers.push(unsupported_event_handler).freeze
          end

          sig { returns(T::Array[T.class_of(BaseEventHandler)]) }
          def supported_event_handlers
            [
              MessageEventHandler,
              ReactionEventHandler,
            ]
          end

          sig { returns(T.class_of(BaseEventHandler)) }
          def unsupported_event_handler
            UnsupportedEventHandler
          end
        end
      end
    end
  end
end
