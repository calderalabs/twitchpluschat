class Channel < TwitchModel
  DEFAULT_DELAY = 60

  cached_resource

  def delay
    super + DEFAULT_DELAY
  end

  def name
    display_name
  end

  def id
    attributes[:name]
  end
end
