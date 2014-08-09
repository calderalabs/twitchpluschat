module LoggingBot
  module Loggers
    class UserDataLogger
      include BaseLogger

      def push(raw_message)
        if raw_message.user.nick == 'jtv'
          parts = raw_message.message.match(/([A-Z]+) (\S+)(?: (.+))?/)

          if parts.present?
            update_from_parts(*parts[1..-1])
          else
            false
          end
        else
          false
        end
      end

      def save
        User.clear
      end

      def update_from_parts(event, nick, value)
        user = User.find_or_create(nick)

        case event
        when 'EMOTESET'
          emoticon_set_ids = JSON.parse(value).map(&:to_s)
          user.emoticon_set_ids = emoticon_set_ids
        when 'USERCOLOR'
          user.color = value
        end

        true
      end
    end
  end
end
