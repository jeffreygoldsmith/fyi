# typed: false
# frozen_string_literal: true

#
# VerifySlackToken (Controller Concern)
#
# This concern is to be included in any controller who's sole purpose is to communicate with Slack.
# In order to learn more about what this is doing and why, consult Slack documentation:
# https://api.slack.com/authentication/verifying-requests-from-slack
#
module VerifySlackToken
  extend ActiveSupport::Concern

  included do
    before_action :verify_token
  end

  private

  MAX_TS_DIFF_SECONDS = 30.seconds

  def verify_token
    hmac_header = request.headers["X-Slack-Signature"]
    timestamp = request.headers["X-Slack-Request-Timestamp"]
    request_body = request.raw_post

    time_diff = (Time.now.to_i - timestamp.to_i).abs
    if time_diff > MAX_TS_DIFF_SECONDS
      message = "Slack webhook secret timestamp over time limit, limit is #{MAX_TS_DIFF_SECONDS}, "\
        "time difference is #{time_diff}"
      Rails.logger.warn(message)
      return head(:unauthorized)
    end

    signature = "v0:#{timestamp}:#{request_body}"
    slack_signing_secret = Rails.application.secrets.slack[:signing_secret]
    calculated_hmac = "v0=" + OpenSSL::HMAC.hexdigest("sha256", slack_signing_secret, signature)

    return if ActiveSupport::SecurityUtils.secure_compare(calculated_hmac, hmac_header)

    Rails.logger.warn("Invalid Slack signature received")
    head(:unauthorized)
  end
end
