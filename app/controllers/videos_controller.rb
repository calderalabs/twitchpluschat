class VideosController < ApplicationController
  respond_to :json

  def show
    json = Rails.cache.fetch("videos/#{params[:id]}") do
      video = Video.find("a#{params[:id]}")
      VideoSerializer.new(video).to_json
    end

    respond_with json
  end
end
