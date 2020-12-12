# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require 'mocha/minitest'

Mocha.configure do |c|
  c.stubbing_method_unnecessarily = :prevent
  c.stubbing_method_on_non_mock_object = :allow
  c.stubbing_method_on_nil = :prevent
end

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
  end

  class ParallelizableTestCase < TestCase
    parallelize(workers: :number_of_processors)
  end
end