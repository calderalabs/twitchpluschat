module LoggingBot
  module Loggers
    module BaseLogger
      def initialize(channel_id)
        @channel_id = channel_id
      end

      def push(raw_message)
        false
      end

      def save; end

      private

      attr_reader :channel_id
    end
  end
end
