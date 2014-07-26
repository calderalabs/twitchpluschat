class EmoticonSerializer < ActiveModel::Serializer
  attributes :id, :width, :height, :url

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

  private

  def image
    object.images.first
  end
end
