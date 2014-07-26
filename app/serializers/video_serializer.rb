class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :recorded_at, :channel_id

  def id
    object._id[1..-1]
  end
end
