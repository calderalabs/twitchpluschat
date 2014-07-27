class EmoticonSetSerializer < ActiveModel::Serializer
  attributes :id
  has_many :emoticons, serializer: EmoticonSerializer
end
