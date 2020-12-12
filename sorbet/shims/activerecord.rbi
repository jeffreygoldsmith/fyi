# typed: true
# These are manually maintained shims for supporting ActiveRecord
# operations. We also have automatically generated RBIs in addition
# to these.

class ActiveRecord::Base
  sig { params(other: BasicObject).returns(T::Boolean) }
  def ==(other); end

  sig { returns(GlobalID) }
  def to_global_id; end

  class << self
    # TODO normally this method could return `Model` or `Array[Model]``,
    # but Sorbet doesn't support overloading yet.
    sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(T.attached_class) }
    def find(*args, &block); end

    sig { params(arg: T.untyped, args: T.untyped).returns(T.nilable(T.attached_class)) }
    def find_by(arg, *args); end

    sig { params(arg: T.untyped, args: T.untyped).returns(T.attached_class) }
    def find_by!(arg, *args); end
  end
end

class ActiveRecord::SorbetRelation < ActiveRecord::Relation
  extend T::Generic
  Elem = type_member

  sig { returns(T.nilable(Elem)) }
  def first; end

  sig { params(block: T.proc.params(arg0: Elem).void).returns(T.untyped) }
  def each(&block); end
end

class ActiveRecord::Associations::CollectionProxy < ::ActiveRecord::Relation
  extend(T::Generic)

  Elem = type_member

  sig { params(block: T.nilable(T.proc.params(arg: Elem).void)).returns(T::Enumerator[Elem]) }
  def each(&block); end

  sig do
    returns(T.untyped)
  end
  def target; end

  sig { void }
  def load_target; end

  sig { void }
  def reload; end

  sig { void }
  def reset; end

  sig { void }
  def reset_scope; end

  sig { returns(T::Boolean) }
  def loaded?; end

  sig { params(args: T.untyped).returns(Elem) }
  def find(*args); end

  # TODO: this has two overloads. It returns T::Array[Elem] when limit is passed
  # and returns Elem when limit is not passed
  def last(limit = nil); end

  # TODO: this has two overloads. It returns T::Array[Elem] when limit is passed
  # and returns Elem when limit is not passed
  def take(limit = nil); end

  sig do
    params(attributes: ::Hash, block: T.nilable(T.proc.returns(T.untyped))).returns(Elem)
  end
  def build(attributes = {}, &block); end

  sig do
    params(attributes: ::Hash, block: T.nilable(T.proc.returns(T.untyped))).returns(Elem)
  end
  def create(attributes = {}, &block); end

  sig do
    params(attributes: ::Hash, block: T.nilable(T.proc.returns(T.untyped))).returns(Elem)
  end
  def create!(attributes = {}, &block); end

  sig { params(records: T.any(Elem, T::Array[Elem], T::Array[ActiveRecord::Associations::CollectionProxy[Elem]])).void }
  def concat(*records); end

  sig { params(other_array: T.any(T::Array[Elem], T.self_type)).void }
  def replace(other_array); end

  sig { params(dependent: ::Symbol).void }
  def delete_all(dependent = nil); end

  sig { void }
  def destroy_all; end

  sig { params(records: T.any(Elem, T::Array[Elem])).void }
  def delete(*records); end

  sig { params(records: T.any(Elem, T::Array[Elem])).void }
  def destroy(*records); end

  def calculate(operation, column_name); end

  def pluck(*column_names); end

  sig { returns(::Integer) }
  def size; end

  sig { returns(T::Boolean) }
  def empty?; end

  sig { params(record: Elem).returns(T::Boolean) }
  def include?(record); end

  def proxy_association; end

  def scope; end

  sig { params(other: T.any(T.self_type, T::Array[Elem])).returns(T::Boolean) }
  def ==(other); end

  sig { params(records: T.any(Elem, T::Array[Elem], T::Array[ActiveRecord::Associations::CollectionProxy[Elem]])).void }
  def <<(*records); end

  sig { params(args: Elem).void }
  def prepend(*args); end

  sig { void }
  def clear; end

  sig { params(fields: T.any(Symbol, String)).returns(ActiveRecord::Associations::CollectionProxy[Elem]) }
  def select(*fields); end
end

module ActiveRecord::TestFixtures::ClassMethods
  def fixture_path=(path); end
end