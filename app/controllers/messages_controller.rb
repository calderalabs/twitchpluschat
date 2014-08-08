class MessagesController < ApplicationController
  respond_to :json

  def index
    batches = MessageBatch.all

    if params[:video_id].present?
      batches = MessageBatch.where(
        "(started_at >= :start_time AND started_at <= :end_time) OR " +
        "(ended_at >= :start_time AND ended_at <= :end_time)",
        start_time: start_time, end_time: end_time
      )

      batches = batches.where(channel_id: video.channel_id)
    end

    respond_with batches.flat_map(&:messages)
  end

  private

  def video
    @video ||= Video.find("a#{params[:video_id]}")
  end

  def start_time
    if params[:from_time].present?
      Time.zone.at(params[:from_time].to_i)
    else
      video.recorded_at
    end
  end

  def end_time
    if params[:to_time].present?
      Time.zone.at(params[:to_time].to_i)
    else
      video.ended_at
    end
  end
end
