class VideoSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id, :title, :recorded_at
  has_one :channel
end
