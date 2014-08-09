class Message
  include BaseModel

  attr_accessor :sent_at, :channel_id, :user_name, :emoticon_set_ids, :color,
                :text, :raw_text
end
