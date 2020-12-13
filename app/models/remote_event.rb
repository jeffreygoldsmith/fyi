class RemoteEvent
  attr_accessor :type, :metadata

  CHANNEL_MESSAGE_EVENT = "message"
  REACTION_ADDED_EVENT = "reaction_added"
  REACTION_REMOVED_EVENT = "reaction_removed"

  def initialize(event:)
    @type = event[:type]
    @metadata = parse_event(event)

    Rails.logger.info("Created remote event with details:\ntype: #{@type}\nmetadata: #{@metadata}")
  end

  private

  def parse_event(event)
    if @type == CHANNEL_MESSAGE_EVENT
      parse_channel_message_event(event)
    elsif @type == REACTION_ADDED_EVENT || @type == REACTION_REMOVED_EVENT
      parse_reaction_event(event)
    end
  end

  def parse_reaction_event(event)
    {
      user: event[:user],
      reaction: event[:reaction],
      message_channel: event[:item][:channel],
      message_timestamp: event[:item][:ts]
    }
  end

  def parse_channel_message_event(event)
    {
      user: event[:user],
      text: event[:text],
      channel: event[:channel],
      timestamp: event[:ts],
    }
  end
end
