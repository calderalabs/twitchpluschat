class MessageSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :text, :created_at, :emoticon_set_ids, :color
end
