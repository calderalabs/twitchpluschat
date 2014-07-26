class Emoticon < TwitchModel
  cached_resource
  self.collection_name = 'chat/emoticons'
end
