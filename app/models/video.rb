class Video < TwitchModel
  cached_resource

  def recorded_at
    super.in_time_zone('UTC')
  end

  def channel
    ::Channel.find(channel_attributes.name)
  end

  def channel_id
    channel_attributes.id
  end

  def ended_at
    recorded_at + length.seconds
  end

  def id
    _id[1..-1]
  end

  private

  def channel_attributes
    attributes[:channel]
  end
end
