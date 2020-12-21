# frozen_string_literal: true
require "test_helper"

class DocumentationTest < ActiveSupport::TestCase
  test "factory bot creates documentation" do
    documentation = create(:documentation)
    assert_equal Documentation.first, documentation
  end
end
