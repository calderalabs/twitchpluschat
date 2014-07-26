class Emoticon < TwitchModel
  cached_resource
  self.collection_name = 'chat/emoticons'

  def id
    regex
  end

  def emoticon_set_id
    images.first.emoticon_set
  end

  def width
    image.width
  end

  def height
    image.height
  end

  def url
    image.url
  end

  private

  def image
    images.first
  end
end
