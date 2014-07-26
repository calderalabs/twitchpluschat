module TwitchFormat
  include ActiveResource::Formats::JsonFormat

  extend self

  def decode(json)
    hash = ActiveSupport::JSON.decode(json)
    hash.delete('_links')
    ActiveResource::Formats.remove_root(hash)
  end
end
