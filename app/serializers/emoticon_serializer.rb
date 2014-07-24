class EmoticonSerializer < ActiveModel::Serializer
  attributes :id, :width, :height, :url, :emoticon_set

  def id
    object.regex
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

  def emoticon_set
    image.emoticon_set
  end

  private

  def image
    object.images.first
  end
end
