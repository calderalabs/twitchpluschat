class MessageSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :text, :sent_at, :emoticon_set_ids, :color
end
