module Cli
  class Application < Thor
    namespace :tpc

    desc 'bot', 'manage the logging bot'
    subcommand 'bot', Cli::Bot
  end
end
