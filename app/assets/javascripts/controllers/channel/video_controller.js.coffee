Twitchpluschat.ChannelVideoController = Ember.ObjectController.extend
  MaxVisibleMessages: 100

  currentTime: null
  messagesSorting: ['timestamp']
  sortedMessages: Ember.computed.sort('messages', 'messagesSorting')

  absoluteCurrentTime: (->
    recordedAt = @get('recordedAt')
    currentTime = @get('currentTime')

    if currentTime?
      new Date(recordedAt.getTime() + currentTime * 1000)
    else
      null
  ).property('currentTime', 'recordedAt')

  pastMessages: ((message) ->
    absoluteCurrentTime = @get('absoluteCurrentTime')

    if absoluteCurrentTime?
      @get('messages').filter (message) ->
        message.get('timestamp') < absoluteCurrentTime
    else
      []
  ).property('messages.@each.timestamp', 'absoluteCurrentTime')

  visibleMessages: (->
    @get('pastMessages').slice(-@get('MaxVisibleMessages') - 1)
  ).property('pastMessages')
