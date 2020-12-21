# typed: strict
# frozen_string_literal: true

module RemoteEvents
  module Slack
    module EventParser
      class Provider
        class << self
          extend(T::Sig)

          sig do
            params(
              event: T::Hash[Symbol, T.untyped],
              event_type: ::Slack::RemoteEvent::Type,
            ).returns(BaseEventParser)
          end
          def provide_for(event:, event_type:)
            T.must(
              parsers.detect do |parser|
                parser.accepts_event_type?(event_type: event_type)
              end
            ).new(event: event, event_type: event_type)
          end

          private

          sig { returns(T::Array[T.class_of(BaseEventParser)]) }
          def parsers
            supported_event_parsers.push(unsupported_event_parser).freeze
          end

          sig { returns(T::Array[T.class_of(BaseEventParser)]) }
          def supported_event_parsers
            []
          end

          sig { returns(T.class_of(BaseEventParser)) }
          def unsupported_event_parser
            UnsupportedEventParser
          end
        end
      end
    end
  end
end
