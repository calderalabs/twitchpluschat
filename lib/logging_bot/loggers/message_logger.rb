module LoggingBot
  module Loggers
    class MessageLogger
      include BaseLogger

      def save
        message_batch.messages << {
          sent_at: raw_message.time.in_time_zone('UTC').as_json,
          channel_id: message_batch.channel_id,
          user_name: user.name,
          emoticon_set_ids: user.emoticon_set_ids,
          color: user.color,
          text: raw_message.message,
          raw_text: raw_message.raw
        }

        true
      end

      protected

      def user
        queue.user(raw_message.user.nick)
      end
    end
  end
end
