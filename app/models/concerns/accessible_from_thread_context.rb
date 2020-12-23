# typed: false
# frozen_string_literal: true
module AccessibleFromThreadContext
  extend ActiveSupport::Concern

  def current
    Thread.current.thread_variable_get(track_current_thread_variable_key)
  end

  def with_current(new_current)
    old_current = current
    self.current = new_current
    yield
  ensure
    self.current = old_current
  end

  private

  def current=(obj)
    Thread.current.thread_variable_set(track_current_thread_variable_key, obj)
  end

  def track_current_thread_variable_key
    @track_current_thread_variable_key ||= "AccessibleFromThreadContext-#{name}"
  end
end
