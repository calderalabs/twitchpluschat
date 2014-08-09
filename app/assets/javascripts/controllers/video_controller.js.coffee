Twitchpluschat.VideoController = Ember.ObjectController.extend Ember.Evented,
  _currentTime: null

  currentTime: ((key, value) ->
    if arguments.length > 1
      current = @get('_currentTime')

      if value != current
        @set('_currentTime', value)
        @trigger('currentTimeDidChange')

    @get('_currentTime')
  ).property()

  absoluteCurrentTime: (->
    recordedAt = @get('recordedAt')
    currentTime = @get('currentTime')
    delay = @get('channel.delay')

    if currentTime?
      new Date(recordedAt.getTime() + (currentTime + delay) * 1000)
    else
      null
  ).property('currentTime', 'recordedAt')
