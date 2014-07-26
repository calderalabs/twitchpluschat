class EmoticonSetsController < ApplicationController
  respond_to :json

  def index
    json = Rails.cache.fetch('emoticon_sets', :expires_in => 1.week) do
      sets = EmoticonSet.all

      ActiveModel::ArraySerializer.new(
            sets,
            each_serializer: EmoticonSetSerializer,
            root: :emoticon_sets
      ).to_json
    end

    respond_with json
  end
end
