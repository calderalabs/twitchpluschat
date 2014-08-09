class EmoticonSet
  include BaseModel

  attr_accessor :emoticons

  def self.all
    Emoticon.all.group_by(&:emoticon_set_id).map do |id, emoticons|
      new(id: id ? id.to_s : 'default', emoticons: emoticons)
    end
  end
end
