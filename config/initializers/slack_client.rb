Slack::Web::Client.configure do |config|
  config.token = Rails.application.secrets.slack[:bot_token]
  config.user_agent = 'Slack Ruby Client/1.0'
end
