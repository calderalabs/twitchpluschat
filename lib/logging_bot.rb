class LoggingBot
  def initialize(nick:, password:, channels:)
    @bot = Cinch::Bot.new do
      configure do |c|
        c.server = 'irc.twitch.tv'
        c.port = 6667
        c.ssl.use = false
        c.nick = nick
        c.password = password
        c.channels = channels.map { |c| "##{c}" }
        c.plugins.plugins = [Plugin]
      end
    end

    @bot.loggers.level = :error
  end

  def start
    bot.start
  end

  private

  attr_reader :bot
end
