# typed: true
# frozen_string_literal: true
module Api
  module RemoteEvents
    class SlackController < ApiController
      include VerifySlackToken
      include Loggable

      URL_VERIFICATION_EVENT = "url_verification"
      EVENT_CALLBACK_EVENT = "event_callback"

      def handle_event
        wrapped_event_type = params[:type]

        fields = {
          wrapped_event_type: wrapped_event_type,
        }
        log_info("Received slack event", fields: fields)

        case wrapped_event_type
        when URL_VERIFICATION_EVENT
          render(plain: params[:challenge])
        when EVENT_CALLBACK_EVENT
          permitted_params = params.require(:event).permit!.to_h
          ::RemoteEvents::Slack::Handler.new(event: permitted_params).handle
          head(:ok)
        else
          head(:bad_request)
        end
      end
    end
  end
end
