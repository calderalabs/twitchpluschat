Twitchpluschat.ChatController = Ember.ArrayController.extend
  MaxVisibleMessages: 100

  _parentController: null

  needs: ['video']
  video: Ember.computed.alias('controllers.video')
  messagesSorting: ['createdAt']
  sortedMessages: Ember.computed.sort('content', 'messagesSorting')
  currentMessages: []

  pastMessages: ((message) ->
    absoluteCurrentTime = @get('video.absoluteCurrentTime')

    if absoluteCurrentTime?
      @get('content').filter (message) ->
        message.get('createdAt') <= absoluteCurrentTime
    else
      []
  ).property('content.@each.createdAt', 'video.absoluteCurrentTime')

  visibleMessages: (->
    @get('pastMessages').slice(-@get('MaxVisibleMessages') - 1)
  ).property('pastMessages')

  parentController: ((key, value) ->
    if arguments.length > 1
      @set('_parentController', value)

      @get('parentController').on('currentTimeDidChange', =>
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

    @get('_parentController')
  ).property()
