# typed: strong

module Loggable
  sig { params(e: T.any(String, StandardError), fields: T::Hash[T.untyped, T.untyped]).void }
  def log_error(e, fields: {}); end

  sig { params(e: T.any(String, StandardError), fields: T::Hash[T.untyped, T.untyped]).void }
  def log_info(e, fields: {}); end

  sig { params(e: T.any(String, StandardError), fields: T::Hash[T.untyped, T.untyped]).void }
  def log_warn(e, fields: {}); end

  sig { params(e: T.any(String, StandardError), fields: T::Hash[T.untyped, T.untyped]).void }
  def log_debug(e, fields: {}); end

  sig { params(e: T.any(String, StandardError), fields: T::Hash[T.untyped, T.untyped]).void }
  def log_fatal(e, fields: {}); end

  sig { params(e: T.any(String, StandardError), fields: T::Hash[T.untyped, T.untyped]).void }
  def log_unknown(e, fields: {}); end
end
