module LoggingBot
  module Loggers
    class MessageLogger
      include BaseLogger

      def push(raw_message)
        user = User.find_or_create(raw_message.user.nick)

        message_batch.push({
          id: SecureRandom.uuid,
          sent_at: raw_message.time.in_time_zone('UTC').as_json,
          user_name: user.name,
          emoticon_set_ids: user.emoticon_set_ids,
          color: user.color,
          text: raw_message.message
        }.stringify_keys)

        true
      end

      def save
        message_batch.save
      end

      private

      def message_batch
        @message_batch ||= MessageBatch.new(channel_id: channel_id)
      end
    end
  end
end
