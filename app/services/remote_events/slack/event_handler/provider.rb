# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventHandler
      class Provider
        class << self
          extend(T::Sig)
          sig { params(remote_event: RemoteEvent).returns(BaseEventHandler) }
          def provide_for(remote_event:)
            T.must(
              handlers.detect do |handler|
                handler.accepts_event_type?(event_type: remote_event.type)
              end
            ).new(remote_event: remote_event)
          end

          sig { returns(T::Array[T.class_of(BaseEventHandler)]) }
          def handlers
            []
          end
        end
      end
    end
  end
end
