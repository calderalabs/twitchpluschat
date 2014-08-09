module LoggingBot
  class Queue
    def initialize
      @raw_messages = []
    end

    def flush
      raw_messages_by_channel.each do |channel_id, raw_messages|
        log_messages(channel_id, raw_messages) if raw_messages.present?
      end

      raw_messages.clear
    end

    def push(raw_message)
      raw_messages.push(raw_message)
    end

    private

    attr_reader :raw_messages

    def raw_messages_by_channel
      raw_messages.group_by { |m| m.channel.name[1..-1] }
    end

    def log_messages(channel_id, raw_messages)
      loggers = Loggers::LOGGERS.map { |l| l.new(channel_id) }

      raw_messages.each do |raw_message|
        loggers.each do |logger|
          break if logger.push(raw_message)
        end
      end

      loggers.each(&:save)
    end
  end
end
