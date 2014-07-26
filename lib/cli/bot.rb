module Cli
  class Bot < Thor
    desc "start", "start the logging bot"
    def start
      LoggingBot.new(Rails.application.secrets.irc.symbolize_keys).start
    end

    default_task :start
  end
end
