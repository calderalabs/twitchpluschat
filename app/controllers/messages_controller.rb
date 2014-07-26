class MessagesController < ApplicationController
  respond_to :json

  def index
    messages = Message.all

    if params[:video_id].present?
      video = Video.find("a#{params[:video_id]}")

      messages = Message.where(
        created_at: (video.recorded_at..video.ended_at),
        channel_id: video.channel.name
      )
    end

    respond_with messages
  end
end
