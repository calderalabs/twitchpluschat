class EmoticonsController < ApplicationController
  respond_to :json

  def index
    emoticons = Emoticon.all
    respond_with emoticons: ActiveModel::ArraySerializer.new(emoticons, each_serializer: EmoticonSerializer)
  end
end
