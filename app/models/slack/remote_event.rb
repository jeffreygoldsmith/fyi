# typed: true
# frozen_string_literal:true
module Slack
  class RemoteEvent
    extend T::Sig
    extend Loggable

    attr_accessor :type, :metadata

    class Type < T::Enum
      enums do
        Message = new("message")
        ReactionAdded = new("reaction_added")
        ReactionRemoved = new("reaction_removed")
        Unknown = new("unknown")
      end
    end

    sig { params(type: Type, metadata: T::Hash[Symbol, T.untyped]).void }
    def initialize(type:, metadata: {})
      @type = type
      @metadata = metadata
    end
  end
end
