class MessageBatch < ActiveRecord::Base
  before_validation :update_interval

  def messages
    super.map { |m| Message.new(m) }
  end

  def push(message)
    messages_will_change!
    self[:messages] << message
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
