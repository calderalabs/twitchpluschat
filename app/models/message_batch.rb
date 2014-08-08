class MessageBatch < ActiveRecord::Base
  before_validation :update_interval

  def update_interval
    self.started_at = messages.first['sent_at']
    self.ended_at = messages.last['sent_at']
  end
end
