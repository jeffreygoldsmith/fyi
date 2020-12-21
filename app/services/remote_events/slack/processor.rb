# typed: true
# frozen_string_literal: true

module RemoteEvents
  module Slack
    class Processor
      extend(T::Sig)

      sig { params(remote_event: ::Slack::RemoteEvent).void }
      def initialize(remote_event:)
        @remote_event = remote_event
      end

      sig { void }
      def process
        event_processor = RemoteEvents::Slack::EventProcessor::Provider.provide_for(remote_event: @remote_event)
        event_processor.process
      end
    end
  end
end
