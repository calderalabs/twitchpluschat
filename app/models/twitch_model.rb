class TwitchModel < ActiveResource::Base
  self.site = 'https://api.twitch.tv/kraken'
  self.headers['Client-ID'] = Rails.application.secrets.twitch_client_id
  self.format = TwitchFormat
  self.include_format_in_path = false

  def read_attribute_for_serialization(name)
    attributes[name]
  end
end
