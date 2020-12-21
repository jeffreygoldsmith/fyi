# frozen_string_literal: true
require 'test_helper'

class LoggableThing
  include Loggable

  def self.do_class_log(level, message, fields: {}, caller_offset: 0)
    case level
    when :debug
      log_debug(message, fields: fields, caller_offset: caller_offset)
    when :info
      log_info(message, fields: fields, caller_offset: caller_offset)
    when :warn
      log_warn(message, fields: fields, caller_offset: caller_offset)
    when :error
      log_error(message, fields: fields, caller_offset: caller_offset)
    when :unknown
      log_unknown(message, fields: fields, caller_offset: caller_offset)
    end
  end

  def do_log(level, message, fields: {}, caller_offset: 0)
    case level
    when :debug
      log_debug(message, fields: fields, caller_offset: caller_offset)
    when :info
      log_info(message, fields: fields, caller_offset: caller_offset)
    when :warn
      log_warn(message, fields: fields, caller_offset: caller_offset)
    when :error
      log_error(message, fields: fields, caller_offset: caller_offset)
    when :unknown
      log_unknown(message, fields: fields, caller_offset: caller_offset)
    end
  end
end

class LoggableTest < ActiveSupport::TestCase
  attr_accessor :thing, :new_stdout

  setup do
    @thing = LoggableThing.new
    @old_stdout = $stdout
    @new_stdout = StringIO.new
    $stdout = @new_stdout
  end

  teardown do
    $stdout = @old_stdout
  end

  test "Loggable defines log_debug log_info log_warn log_error and log_unknown methods on the class" do
    assert_respond_to LoggableThing, :log_debug
    assert_respond_to LoggableThing, :log_info
    assert_respond_to LoggableThing, :log_warn
    assert_respond_to LoggableThing, :log_error
    assert_respond_to LoggableThing, :log_unknown
  end

  test "Loggable defines log_debug log_info log_warn log_error and log_unknown methods on the instance" do
    assert_respond_to thing, :log_debug
    assert_respond_to thing, :log_info
    assert_respond_to thing, :log_warn
    assert_respond_to thing, :log_error
    assert_respond_to thing, :log_unknown
  end

  test "class#log_debug logs a DEBUG level message with the expected format and prints it to the console" do
    assert_logs(:debug, "[LoggableThing]#do_class_log hello") do
      LoggableThing.do_class_log(:debug, "hello")
    end
    assert_equal "[LoggableThing]#do_class_log hello", new_stdout.string.strip
  end

  %i(info warn error unknown).each do |level|
    test "class#log_#{level} logs an #{level.upcase} level message with the expected format and level but doesnt print" do
      assert_logs(level, "[LoggableThing]#do_class_log hello") do
        LoggableThing.do_class_log(level, "hello")
      end
      assert_predicate new_stdout.string, :blank?
    end
  end

  %i(debug info warn error unknown).each do |level|
    test "class#log_#{level} can walk the stack to select the caller method name" do
      assert_logs(level, "[LoggableThing]#<class:LoggableTest> hello") do
        LoggableThing.do_class_log(level, "hello", caller_offset: 1)
      end
    end
  end

  %i(debug info warn error unknown).each do |level|
    test "class#log_#{level} formats the given fields properly" do
      assert_logs(level, '[LoggableThing]#do_class_log hello foo: "10", bar: "thing"') do
        LoggableThing.do_class_log(level, "hello", fields: { foo: 10, bar: 'thing' })
      end
    end
  end

  test "instance#log_debug logs a DEBUG level message with the expected format and prints it to the console" do
    assert_logs(:debug, "[LoggableThing]#do_log hello") do
      thing.do_log(:debug, "hello")
    end

    assert_equal "[LoggableThing]#do_log hello", new_stdout.string.strip
  end

  %i(info warn error unknown).each do |level|
    test "instance#log_#{level} logs an #{level.upcase} level message with the expected format and level but doesnt print" do
      assert_logs(level, "[LoggableThing]#do_log hello") do
        thing.do_log(level, "hello")
      end
      assert_predicate new_stdout.string, :blank?
    end
  end

  %i(debug info warn error unknown).each do |level|
    test "instance#log_#{level} can walk the stack to select the caller method name" do
      assert_logs(level, "[LoggableThing]#<class:LoggableTest> hello") do
        thing.do_log(level, "hello", caller_offset: 1)
      end
    end
  end

  %i(debug info warn error unknown).each do |level|
    test "instance#log_#{level} formats the given fields properly" do
      Rails.application.config.expects(:filter_parameters).returns([:private_information])
      assert_logs(level, '[LoggableThing]#do_log hello foo: "10", bar: "thing", private_information: "[FILTERED]"') do
        thing.do_log(level, "hello", fields: { foo: 10, bar: 'thing', private_information: "1234" })
      end
    end
  end
end
