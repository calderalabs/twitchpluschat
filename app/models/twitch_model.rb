class TwitchModel < ActiveResource::Base
  include ActiveModel::SerializerSupport

  self.site = 'https://api.twitch.tv/kraken'
  self.headers['Client-ID'] = Rails.application.secrets.twitch_client_id
  self.format = TwitchFormat
  self.include_format_in_path = false
end
