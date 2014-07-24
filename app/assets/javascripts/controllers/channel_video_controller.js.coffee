Twitchpluschat.ChannelVideoController = Ember.ObjectController.extend
  currentTime: null

  absoluteCurrentTime: (->
    recordedAt = @get('recordedAt')
    currentTime = @get('currentTime')

    if currentTime?
      new Date(recordedAt.getTime() + currentTime * 1000)
    else
      null
  ).property('currentTime', 'recordedAt')
