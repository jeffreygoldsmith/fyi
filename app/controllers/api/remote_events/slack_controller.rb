# typed: true
# frozen_string_literal: true
module Api
  module RemoteEvents
    class SlackController < ApiController
      include VerifySlackToken

      URL_VERIFICATION_EVENT = "url_verification"
      EVENT_CALLBACK_EVENT = "event_callback"

      def handle_event
        wrapped_event_type = params[:type]

        Rails.logger.info("Received slack event with wrapped type: #{wrapped_event_type}")

        case wrapped_event_type
        when URL_VERIFICATION_EVENT
          render(plain: params[:challenge])
        when EVENT_CALLBACK_EVENT
          remote_event = ::RemoteEvents::Slack::Parser.new(event: params[:event]).parse
          processor = ::RemoteEvents::Slack::Processor.new(remote_event: remote_event)
          processor.process
          head(:ok)
        else
          head(:bad_request)
        end
      end
    end
  end
end
