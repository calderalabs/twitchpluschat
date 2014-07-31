class MessagesController < ApplicationController
  respond_to :json

  def index
    messages = Message.all

    if params[:video_id].present?
      messages = Message.where(
        created_at: (start_time..end_time),
        channel_id: video.channel_id
      ).includes(:user)
    end

    respond_with messages
  end

  private

  def video
    @video ||= Video.find("a#{params[:video_id]}")
  end

  def start_time
    if params[:from_time].present?
      Time.at(params[:from_time].to_i).to_datetime
    else
      video.recorded_at
    end
  end

  def end_time
    if params[:to_time].present?
      Time.at(params[:to_time].to_i).to_datetime
    else
      video.ended_at
    end
  end
end
