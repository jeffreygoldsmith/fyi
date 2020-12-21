# typed: true
# frozen_string_literal:true
module Slack
  class RemoteEvent
    extend T::Sig
    extend Loggable

    attr_accessor :type, :user_id, :metadata

    class Type < T::Enum
      enums do
        Message = new("message")
        ReactionAdded = new("reaction_added")
        ReactionRemoved = new("reaction_removed")
        Unknown = new("unknown")
      end
    end

    sig do
      params(
        type: Type,
        user_id: String,
        metadata: T::Hash[Symbol, T.untyped]
      ).void
    end
    def initialize(type:, user_id:, metadata: {})
      @type = type
      @user_id = user_id
      @metadata = metadata
    end
  end
end
