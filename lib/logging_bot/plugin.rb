class LoggingBot
  class Plugin
    include Cinch::Plugin

    listen_to :channel, :method => :log_message

    private

    def log_message(m)
      Message.create(
        channel_id: m.channel.name[1..-1],
        user_id: m.user.nick,
        text: m.message
      )
    end
  end
end
