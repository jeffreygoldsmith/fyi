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
              processors.detect do |processor|
                processor.accepts_event_type?(event_type: remote_event.type)
              end
            ).new(remote_event: remote_event)
          end

          private

          sig { returns(T::Array[T.class_of(BaseEventProcessor)]) }
          def processors
            supported_event_processors.push(unsupported_event_processor).freeze
          end

          sig { returns(T::Array[T.class_of(BaseEventProcessor)]) }
          def supported_event_processors
            []
          end

          sig { returns(T.class_of(BaseEventProcessor)) }
          def unsupported_event_processor
            UnsupportedEventProcessor
          end
        end
      end
    end
  end
end
