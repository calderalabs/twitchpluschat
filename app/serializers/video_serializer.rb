class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :recorded_at, :channel_id
end
