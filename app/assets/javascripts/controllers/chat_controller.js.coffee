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
    MaxVisibleMessages = @get('MaxVisibleMessages')
    currentMessages = @get('currentMessages')

    @beginPropertyChanges()

    if currentTime > previousTime
      lastBatchIndex = batch.mapBy('id').indexOf(currentMessages.get('lastObject.id'))
      lastBatchIndex = 0 if lastBatchIndex == -1

      for message in batch[lastBatchIndex..-1]
        if message.get('createdAt') <= currentTime && !currentMessages.findBy('id', message.get('id'))?
          currentMessages.pushObject(message)
    else
      while (message = currentMessages.get('lastObject'))? && message.get('createdAt') > currentTime
        currentMessages.popObject()

    while currentMessages.get('length') > MaxVisibleMessages
      currentMessages.shiftObject()

    @endPropertyChanges()
