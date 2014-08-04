Twitchpluschat.ChatController = Ember.ArrayController.extend
  MaxVisibleMessages: 50

  needs: ['video']
  video: Ember.computed.alias('controllers.video')
  lastBatch: null
  currentMessages: []
  _parentController: null

  sortedMessages: (->
    @get('content').sortBy('createdAt')
  ).property('content')

  pastMessages: (->
    absoluteCurrentTime = @get('video.absoluteCurrentTime')

    if absoluteCurrentTime?
      @get('sortedMessages').filter (message) =>
        message.get('createdAt') <= absoluteCurrentTime
    else
      []
  ).property('video.absoluteCurrentTime')

  visibleMessages: (->
    @get('pastMessages').slice(-@get('MaxVisibleMessages'))
  ).property('video.absoluteCurrentTime')

  parentController: ((key, value) ->
    if arguments.length > 1
      @set('_parentController', value)

      @get('parentController').on 'currentTimeDidChange', =>
        @findMessagesAtCurrentTime() if @get('video.absoluteCurrentTime')?

    @get('_parentController')
  ).property()

  findMessagesAtCurrentTime: ->
    @store.findMessages(
      videoId: @get('video.id'),
      atTime: @get('video.absoluteCurrentTime'),
      minTime: @get('video.recordedAt')
    ).then (currentBatch) =>
      if currentBatch != @get('lastBatch')
        @set('content', @store.all('message').toArray())
        @set('lastBatch', currentBatch)

      @updateMessages()

  updateMessages: ->
    allMessages = @get('content')
    currentMessages = @get('currentMessages')
    visibleMessages = @get('visibleMessages')
    lastBatch = @get('lastBatch')

    @beginPropertyChanges()

    currentMessages.forEach (message) ->
      if visibleMessages.indexOf(message) == -1
        currentMessages.removeObject(message)

    visibleMessages.forEach (message, index) ->
      if currentMessages.indexOf(message) == -1
        currentMessages.insertAt(index, message)

    @endPropertyChanges()
