# frozen_string_literal: true
FactoryBot.define do
  factory :documentation, class: Documentation do
    text { "rollback the most recent migration with rails db:rollback" }
    slack_user_id { "W1234567890" }
    slack_channel_id { "C1234567890" }
    slack_timestamp { "1355517523.000005" }
  end
end
