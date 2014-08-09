class Message
  include BaseModel

  attr_accessor :sent_at, :user_name, :emoticon_set_ids, :color, :text
end
