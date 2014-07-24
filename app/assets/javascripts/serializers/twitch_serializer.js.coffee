Twitchpluschat.TwitchSerializer = DS.ActiveModelSerializer.extend
  defaultSerializer: 'twitch'
  primaryKey: '_id'

  extract: (store, type, payload, id, requestType) ->
    value = {}
    value[type.typeKey] = payload
    @_super(store, type, value, id, requestType)
