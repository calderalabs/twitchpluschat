class LoggingBot
  class Plugin
    include Cinch::Plugin

    listen_to :channel, :method => :log_message

    private

    def log_message(m)
      puts "#{m.user.nick}: #{m.message}"
    end
  end
end
