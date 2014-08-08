module LoggingBot
  class Plugin
    include Cinch::Plugin

    listen_to :connect, method: :initialize_client
    listen_to :channel, method: :enqueue_message
    timer 30, method: :flush_queue, threaded: false

    private

    attr_reader :queue, :users

    def initialize_client(*args)
      @queue = LoggingBot::Queue.new

      bot.irc.send('TWITCHCLIENT 3')

      at_exit do
        flush_queue
      end
    end

    def enqueue_message(m)
      queue.push(m)
    end

    def flush_queue
      queue.flush
    end
  end
end
