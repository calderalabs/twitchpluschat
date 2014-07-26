class Video < TwitchModel
  def ended_at
    recorded_at + length.seconds
  end
end
