Twitchpluschat.ChatController = Ember.ArrayController.extend
  MaxVisibleMessages: 100

  needs: ['channelVideo']
  absoluteCurrentTime: Ember.computed.alias('controllers.channelVideo.absoluteCurrentTime')
  messagesSorting: ['timestamp']

  sortedMessages: Ember.computed.sort('content', 'messagesSorting')

  pastMessages: ((message) ->
    absoluteCurrentTime = @get('absoluteCurrentTime')

    if absoluteCurrentTime?
      @get('content').filter (message) ->
        message.get('timestamp') < absoluteCurrentTime
    else
      []
  ).property('content.@each.timestamp', 'absoluteCurrentTime')

  arrangedContent: (->
    @get('pastMessages').slice(-@get('MaxVisibleMessages') - 1)
  ).property('pastMessages')
