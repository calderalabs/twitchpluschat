module LoggingBot
  class Queue
    def initialize
      @raw_messages = []
      @users = {}
    end

    def flush
      raw_messages_by_channel.each do |channel_id, raw_messages|
        log_message_batch(channel_id, raw_messages) if raw_messages.present?
      end

      raw_messages.clear
      users.values.each(&:save)
      users.clear
    end

    def push(raw_message)
      raw_messages.push(raw_message)
    end

    def user(id)
      users[id] ||= User.find_or_create_by(name: id)
    end

    private

    attr_reader :raw_messages, :users

    def raw_messages_by_channel
      raw_messages.group_by { |m| m.channel.name[1..-1] }
    end

    def log_message_batch(channel_id, raw_messages)
      message_batch = MessageBatch.new(channel_id: channel_id)

      raw_messages.each do |raw_message|
        Loggers::LOGGERS.each do |logger|
          break if logger.new(
            queue: self,
            message_batch: message_batch,
            raw_message: raw_message
          ).save
        end
      end

      message_batch.save
    end
  end
end
