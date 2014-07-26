class LoggingBot
  class Plugin
    include Cinch::Plugin

    listen_to :connect, method: :on_connect
    listen_to :channel, method: :on_message

    private

    def on_connect(m)
      bot.irc.send('TWITCHCLIENT 3')
    end

    def on_message(m)
      if m.user.nick == 'jtv'
        update_user_data(m)
      else
        log_message(m)
      end
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
