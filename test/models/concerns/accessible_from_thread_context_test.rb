# typed: true
# frozen_string_literal: true
require 'test_helper'

class AccessibleFromThreadContextTest < ActiveSupport::TestCase
  class TestObject
    extend AccessibleFromThreadContext
  end

  class TestAlternateObject
    extend AccessibleFromThreadContext
  end

  test "#current is nil when not set" do
    TestObject.with_current(nil) do
      assert_nil(TestObject.current)
    end
  end

  test "#with_current only mutates the current value within the associated block" do
    assert_nil(TestObject.current)

    TestObject.with_current(:object_a) do
      assert_equal(:object_a, TestObject.current)

      TestObject.with_current(:object_b) do
        assert_equal(:object_b, TestObject.current)
      end

      assert_equal(:object_a, TestObject.current)
    end

    assert_nil(TestObject.current)
  end

  test "is threadsafe" do
    TestObject.with_current(:object_a) do
      assert_equal(:object_a, TestObject.current)

      Thread.new do
        TestObject.with_current(:object_b) do
          assert_equal(:object_b, TestObject.current)
        end
      end.join

      assert_equal(:object_a, TestObject.current)
    end
  end

  test "current variable is not shared between objects" do
    TestObject.with_current(:object_a) do
      TestAlternateObject.with_current(:object_b) do
        assert_equal(:object_a, TestObject.current)
        assert_equal(:object_b, TestAlternateObject.current)
      end
    end
  end
end
