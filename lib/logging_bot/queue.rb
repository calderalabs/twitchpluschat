module LoggingBot
  class Queue
    def initialize
      @raw_messages = []
      @users = {}
    end

    def flush
      raw_messages.each do |raw_message|
        if raw_message.user.nick == 'jtv'
          update_user_data(raw_message)
        else
          log_message(raw_message)
        end
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

    def update_user_data(raw_message)
      raw_message.message.scan(/(\S+) (\S+) (.+)/) do |event, nick, value|
        user = user(nick)

        case event
        when 'EMOTESET'
          emoticon_set_ids = JSON.parse(value).map(&:to_s)
          user.emoticon_set_ids = emoticon_set_ids
        when 'USERCOLOR'
          user.color = value
        end
      end
    end

    def log_message(raw_message)
      user = user(raw_message.user.nick)

      Message.create(
        created_at: raw_message.time,
        channel_id: raw_message.channel.name[1..-1],
        user_name: user.name,
        emoticon_set_ids: user.emoticon_set_ids,
        color: user.color,
        text: raw_message.message
      )
    end

    def user(id)
      users[id] ||= User.find_or_create_by(name: id)
    end
  end
end
