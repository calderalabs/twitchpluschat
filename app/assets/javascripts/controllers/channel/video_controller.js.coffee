Twitchpluschat.ChannelVideoController = Ember.ObjectController.extend
  MaxVisibleMessages: 100

  currentTime: null
  messagesSorting: ['timestamp']
  sortedMessages: Ember.computed.sort('messages', 'messagesSorting')

  absoluteCurrentTime: (->
    recordedAt = @get('recordedAt')
    currentTime = @get('currentTime')

    return null unless currentTime?
    new Date(recordedAt.getTime() + currentTime * 1000)
  ).property('currentTime', 'recordedAt')

  pastMessages: ((message) ->
    absoluteCurrentTime = @get('absoluteCurrentTime')
    return [] unless absoluteCurrentTime?

    @get('messages').filter (message) ->
      message.get('timestamp') < absoluteCurrentTime
  ).property('messages.@each.timestamp', 'absoluteCurrentTime')

  visibleMessages: (->
    @get('pastMessages').slice(-@get('MaxVisibleMessages') - 1)
  ).property('pastMessages')
