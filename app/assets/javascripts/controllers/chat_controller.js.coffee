Twitchpluschat.ChatController = Ember.ArrayController.extend
  MaxVisibleMessages: 50

  needs: ['video']
  video: Ember.computed.alias('controllers.video')
  lastBatch: null
  lastVisibleMessages: null
  currentMessages: []
  _parentController: null

  sortedMessages: (->
    @get('content').sortBy('createdAt')
  ).property('content')

  pastMessages: (->
    absoluteCurrentTime = @get('video.absoluteCurrentTime')

    pastMessages = []

    if absoluteCurrentTime?
      for message in @get('sortedMessages')
        if message.get('createdAt') <= absoluteCurrentTime
          pastMessages.push(message)

    pastMessages
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
    visibleMessages = @get('visibleMessages')
    return if visibleMessages == @get('lastVisibleMessages')
    @set('lastVisibleMessages', visibleMessages)

    allMessages = @get('content')
    currentMessages = @get('currentMessages')
    currentMessageIds = currentMessages.mapBy('id')
    visibleMessagesIds = visibleMessages.mapBy('id')
    lastBatchIds = @get('lastBatch').mapBy('id')

    @beginPropertyChanges()

    allMessages.forEach (message) ->
      if lastBatchIds.indexOf(message.get('id')) == -1 && visibleMessagesIds.indexOf(message.get('id')) == -1
        message.unloadRecord()

    currentMessages.forEach (message, index) ->
      if visibleMessagesIds.indexOf(message.get('id')) == -1
        currentMessages.removeAt(index)

    visibleMessages.forEach (message, index) ->
      if currentMessageIds.indexOf(message.get('id')) == -1
        if message.get('createdAt') >= currentMessages.get('lastObject.createdAt')
          currentMessages.pushObject(message)
        else
          currentMessages.insertAt(0, message)

    @endPropertyChanges()
