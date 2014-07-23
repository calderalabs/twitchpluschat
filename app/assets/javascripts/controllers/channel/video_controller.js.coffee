Twitchpluschat.ChannelVideoController = Ember.ObjectController.extend
  currentTime: null

  visibleMessages: (->
    currentTime = @get('currentTime')
    return [] unless currentTime?

    @get('messages').filter (message) ->
      message.get('timestamp') < currentTime
  ).property('messages.@each.timestamp', 'currentTime')
