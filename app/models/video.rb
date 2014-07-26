class Video < TwitchModel
  def channel_id
    channel.name
  end

  def ended_at
    recorded_at + length.seconds
  end

  def id
    _id[1..-1]
  end
end
