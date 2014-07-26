class EmoticonSetSerializer < ActiveModel::Serializer
  embed :ids, include: true
  attributes :id
  has_many :emoticons, serializer: EmoticonSerializer, root: :emoticons
end
