class Video < TwitchModel
  def channel_id
    channel.name
  end

  def ended_at
    recorded_at + length.seconds
  end
end
