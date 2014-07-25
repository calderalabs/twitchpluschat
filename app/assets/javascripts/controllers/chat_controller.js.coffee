Twitchpluschat.ChatController = Ember.ArrayController.extend
  MaxVisibleMessages: 100

  needs: ['channelVideo']
  channelVideo: Ember.computed.alias('controllers.channelVideo')
  messagesSorting: ['timestamp']
  sortedMessages: Ember.computed.sort('content', 'messagesSorting')
  currentMessages: []
  arrangedContent: Ember.computed.alias('currentMessages')

  pastMessages: ((message) ->
    absoluteCurrentTime = @get('channelVideo.absoluteCurrentTime')

    if absoluteCurrentTime?
      @get('content').filter (message) ->
        message.get('timestamp') < absoluteCurrentTime
    else
      []
  ).property('content.@each.timestamp', 'channelVideo.absoluteCurrentTime')

  visibleMessages: (->
    @get('pastMessages').slice(-@get('MaxVisibleMessages') - 1)
  ).property('pastMessages')

  parentControllerDidChange: (->
    @get('parentController').on('currentTime:change', =>
      currentMessages = @get('currentMessages')
      visibleMessages = @get('visibleMessages')

      currentMessages.beginPropertyChanges()

      currentMessages.forEach (message) ->
        if visibleMessages.indexOf(message) == -1
          currentMessages.removeObject(message)

      visibleMessages.forEach (message, index) ->
        if currentMessages.indexOf(message) == -1
          currentMessages.insertAt(index, message)

      currentMessages.endPropertyChanges()
    )
  ).observes('parentController').on('init')
