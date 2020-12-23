# typed: false
# frozen_string_literal: true
class Documentation < ApplicationRecord
  self.table_name = "documentation"

  FORMATTED_DOCUMENTATION = "[%s %s %s] %s"
  FORMATTED_TIME = "%a %b %e %T %Z %Y"

  def format(channel_name:, user_name:)
    FORMATTED_DOCUMENTATION % [
      updated_at.strftime(FORMATTED_TIME),
      "#" + channel_name,
      "@" + user_name,
      text,
    ]
  end
end
