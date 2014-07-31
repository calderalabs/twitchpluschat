class EmoticonSerializer < ActiveModel::Serializer
  attributes :regexp, :width, :height, :url
end
