class EmoticonSet
  include ActiveModel::SerializerSupport

  attr_accessor :emoticons, :id

  def self.all
    Emoticon.all.group_by(&:emoticon_set_id).map do |id, emoticons|
      new(id: id, emoticons: emoticons)
    end
  end

  def initialize(id:, emoticons:)
    @id = id || 'default'
    @emoticons = emoticons
  end
end
