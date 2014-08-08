module LoggingBot
  module Loggers
    module BaseLogger
      def initialize(queue:, message_batch:, raw_message:)
        @queue = queue
        @message_batch = message_batch
        @raw_message = raw_message
      end

      def save
        true
      end

      protected

      attr_reader :queue, :message_batch, :raw_message
    end
  end
end
