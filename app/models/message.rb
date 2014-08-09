class Message < OpenStruct
 include ActiveModel::SerializerSupport

  def initialize(attributes)
    super(attributes)
  end
end
