Twitchpluschat.VideoSerializer = Twitchpluschat.TwitchSerializer.extend
  normalize: (type, hash, prop) ->
    hash._id = hash._id.substring(1)
    @_super(type, hash, prop)
