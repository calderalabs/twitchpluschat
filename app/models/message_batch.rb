class MessageBatch < ActiveRecord::Base
  before_validation :update_interval

  def push(message)
    messages_will_change!
    messages << message
  end

  def update_interval
    if messages.present?
      self.started_at = messages.first['sent_at']
      self.ended_at = messages.last['sent_at']
    else
      false
    end
  end
end
