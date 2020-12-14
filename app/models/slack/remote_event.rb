# typed: true
# frozen_string_literal:true
module Slack
  class RemoteEvent
    extend T::Sig
    extend Loggable

    attr_accessor :type, :metadata

    class Type < T::Enum
      enums do
        ChannelMessage = new("message")
        ReactionAdded = new("reaction_added")
        ReactionRemoved = new("reaction_removed")
        Unknown = new("unknown")
      end
    end

    sig { params(type: Type, metadata: T::Hash[Symbol, T.untyped]).void }
    def initialize(type:, metadata:)
      @type = type
      @metadata = metadata
    end

    sig do
      params(
        type: String,
        event: T::Hash[Symbol, T.untyped]
      ).returns(RemoteEvent)
    end
    def self.construct_event(type:, event:)
      type = Type.try_deserialize(type) || Type::Unknown
      metadata = case @type
      when Type::ChannelMessage
        parse_channel_message_event(event)
      when Type::ReactionAdded
        parse_reaction_event(event)
      when Type::ReactionRemoved
        parse_reaction_event(event)
      else
        {}
      end

      fields = {
        type: @type,
        metadata: @metadata,
      }
      log_info("Created remote event", fields: fields)

      RemoteEvent.new(type: type, metadata: metadata)
    end

    private

    sig do
      params(
        event: T::Hash[T.untyped, T.untyped]
      ).returns(T::Hash[Symbol, T.untyped])
    end
    def self.parse_reaction_event(event)
      {
        user: event[:user],
        reaction: event[:reaction],
        message_channel: event[:item][:channel],
        message_timestamp: event[:item][:ts]
      }
    end

    sig do
      params(
        event: T::Hash[T.untyped, T.untyped]
      ).returns(T::Hash[Symbol, T.untyped])
    end
    def self.parse_channel_message_event(event)
      {
        user: event[:user],
        text: event[:text],
        channel: event[:channel],
        timestamp: event[:ts],
      }
    end
  end
end
