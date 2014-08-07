module LoggingBot
  class Queue
    def initialize
      @raw_messages = []
      @users = {}
    end

    def flush
      raw_messages.group_by { |m| m.channel.name }.each do |channel, raw_messages|
        channel_id = channel.name[1..-1]
        log_message_batch(channel_id, raw_messages) if raw_messages.present?
      end

      raw_messages.clear
      users.values.each(&:save)
      users.clear
    end

    def push(raw_message)
      raw_messages.push(raw_message)
    end

    private

    attr_reader :raw_messages, :users

    def log_message_batch(channel_id, raw_messages)
      message_batch = MessageBatch.new(channel_id: channel_id)

      raw_messages.each do |raw_message|
        unless update_user_data(raw_message)
          message_batch.messages << extract_message(channel_id, raw_message)
        end
      end

      message_batch.save
    end

    def update_user_data(raw_message)
      if raw_message.user.nick == 'jtv'
        parts = raw_message.message.match(/(\S+) (\S+) (.+)/)

        if parts.present?
          update_user_from_parts(*parts)
        else
          false
        end
      else
        false
      end
    end

    def update_user_from_parts(event, nick, value)
      user = user(nick)

      case event
      when 'EMOTESET'
        emoticon_set_ids = JSON.parse(value).map(&:to_s)
        user.emoticon_set_ids = emoticon_set_ids
      when 'USERCOLOR'
        user.color = value
      end

      true
    end

    def extract_message(channel_id, raw_message)
      user = user(raw_message.user.nick)

      {
        created_at: raw_message.time,
        channel_id: channel_id,
        user_name: user.name,
        emoticon_set_ids: user.emoticon_set_ids,
        color: user.color,
        text: raw_message.message
        raw_text: raw_message.raw
      }
    end

    def user(id)
      users[id] ||= User.find_or_create_by(name: id)
    end
  end
end
