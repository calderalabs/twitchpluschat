class VideosController < ApplicationController
  respond_to :json

  def show
    video = Video.find("a#{params[:id]}")
    respond_with VideoSerializer.new(video).to_json
  end
end
