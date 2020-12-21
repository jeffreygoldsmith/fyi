# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventProcessor
      class Provider
        class << self
          extend(T::Sig)
          sig { params(remote_event: ::Slack::RemoteEvent).returns(BaseEventProcessor) }
          def provide_for(remote_event:)
            T.must(
              handlers.detect do |handler|
                handler.accepts_event_type?(event_type: remote_event.type)
              end
            ).new(remote_event: remote_event)
          end

          private

          sig { returns(T::Array[T.class_of(BaseEventProcessor)]) }
          def handlers
            supported_event_handlers.push(unsupported_event_handler).freeze
          end

          sig { returns(T::Array[T.class_of(BaseEventProcessor)]) }
          def supported_event_handlers
            []
          end

          sig { returns(T.class_of(BaseEventProcessor)) }
          def unsupported_event_handler
            UnsupportedEventProcessor
          end
        end
      end
    end
  end
end
