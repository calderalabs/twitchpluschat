Twitchpluschat.ChannelVideoController = Ember.ObjectController.extend Ember.Evented,
  _currentTime: null

  currentTime: ((key, value)->
    if arguments.length > 1
      @set('_currentTime', value)
      @trigger('currentTimeDidChange')

    @get('_currentTime')
  ).property()

  absoluteCurrentTime: (->
    recordedAt = @get('recordedAt')
    currentTime = @get('currentTime')

    if currentTime?
      new Date(recordedAt.getTime() + currentTime * 1000)
    else
      null
  ).property('currentTime', 'recordedAt')
