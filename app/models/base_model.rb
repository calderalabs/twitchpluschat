module BaseModel
  extend ActiveSupport::Concern
  include ActiveModel::SerializerSupport

  attr_accessor :id

  def initialize(attributes)
    attributes.each do |attribute, value|
      send("#{attribute}=", value)
    end
  end
end
