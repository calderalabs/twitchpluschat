class LoggingBot
  class Plugin
    include Cinch::Plugin

    listen_to :connect, method: :initialize_client
    listen_to :channel, method: :enqueue_message
    timer 60, method: :flush_queue

    private

    attr_reader :message_queue

    def initialize_client(m)
      @message_queue = []

      bot.irc.send('TWITCHCLIENT 3')

      at_exit do
        flush_queue
      end
    end

    def enqueue_message(m)
      message_queue << m
    end

    def flush_queue
      message_queue.each do |m|
        if m.user.nick == 'jtv'
          update_user_data(m)
        else
          log_message(m)
        end
      end

      message_queue.clear
    end

    def update_user_data(m)
      m.message.scan(/(\S+) (\S+) (.+)/) do |event, user_id, value|
        case event
        when 'EMOTESET'
          emoticon_set_ids = JSON.parse(value).map(&:to_s)
          user = User.find_or_create_by(name: user_id)
          user.update_attributes(emoticon_set_ids: emoticon_set_ids)
        end
      end
    end

    def log_message(m)
      Message.create(
        channel_id: m.channel.name[1..-1],
        user: User.find_or_create_by(name: m.user.nick),
        text: m.message
      )
    end
  end
end
