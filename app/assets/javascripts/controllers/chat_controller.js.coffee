Twitchpluschat.ChatController = Ember.ArrayController.extend
  MaxVisibleMessages: 50

  needs: ['video']
  video: Ember.computed.alias('controllers.video')
  currentMessages: []
  currentTime: null
  currentPromise: null

  videoControllerDidChange: (->
    controller = @get('video')

    if controller?
      controller.on 'currentTimeDidChange', =>
        previousTime = @get('currentTime') ? 0
        currentTime = controller.get('absoluteCurrentTime')
        @set('currentTime', currentTime)

        @findMessagesAtCurrentTime(previousTime, currentTime) if currentTime?
  ).observes('video').on('init')

  findMessagesAtCurrentTime: (previousTime, currentTime) ->
    promise = @store.findMessages(
      videoId: @get('video.id'),
      atTime: currentTime,
      minTime: @get('video.recordedAt')
    )

    @set('currentPromise', promise)

    promise.then (batch) =>
      if promise == @get('currentPromise')
        @updateCurrentMessages(batch, previousTime, currentTime)

  updateCurrentMessages: (batch, previousTime, currentTime) ->
    currentMessages = @get('currentMessages')
    @beginPropertyChanges()

    if currentTime > previousTime
      @addPastMessagesFromBatch(currentMessages, batch, currentTime)
    else
      @removeFutureMessages(currentMessages, currentTime)

    @removeExceedingMessages(currentMessages)
    @endPropertyChanges()

  addPastMessagesFromBatch: (messages, batch, time) ->
    lastBatchIndex = _(batch.mapBy('id')).indexOf(
      messages.get('lastObject.id'),
      true
    )

    startingIndex = if lastBatchIndex == -1 then 0 else lastBatchIndex

    for message in batch[startingIndex..-1]
      isPast = message.get('sentAt') <= time
      isAlreadyAdded = messages.findBy('id', message.get('id'))?

      if isPast && !isAlreadyAdded
        messages.pushObject(message)

  removeFutureMessages: (messages, time) ->
    message = messages.get('lastObject')

    while message? && message.get('sentAt') > time
      messages.popObject()
      message = messages.get('lastObject')

  removeExceedingMessages: (messages) ->
    MaxVisibleMessages = @get('MaxVisibleMessages')

    while messages.get('length') > MaxVisibleMessages
      messages.shiftObject()
