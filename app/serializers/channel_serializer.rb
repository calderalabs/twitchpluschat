class ChannelSerializer < ActiveModel::Serializer
  attributes :id, :name, :delay, :url
end
