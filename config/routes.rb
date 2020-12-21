# typed: false
# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :remote_events do
      post "/slack", to: "slack#handle_event"
    end
  end
end
