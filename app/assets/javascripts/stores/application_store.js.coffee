Twitchpluschat.ApplicationStore = DS.Store.extend
  MessagesTimeInterval: 60

  lastMessagesFromTime: null
  lastMessagesToTime: null
  lastMessages: null

  findMessages: (params) ->
    TimeInterval = @get('MessagesTimeInterval') / 2

    atTime = params.atTime ? new Date()
    minTime = params.minTime ? params.atTime
    lastMessagesFromTime = @get('lastMessagesFromTime')
    lastMessagesToTime = @get('lastMessagesToTime')
    lastMessages = @get('lastMessages')
    isCached = lastMessages? && atTime > lastMessagesFromTime && atTime < lastMessagesToTime

    unless isCached
      fromTime = new Date(atTime)
      fromTime.setSeconds(fromTime.getSeconds() - TimeInterval)
      fromTime = new Date(Math.max(minTime, fromTime))

      toTime = new Date(atTime)
      toTime.setSeconds(toTime.getSeconds() + TimeInterval)
      toTime = new Date(Math.max(minTime, toTime))

      if lastMessages?
        if toTime > lastMessagesToTime
          fromTime = new Date(Math.max(fromTime, lastMessagesToTime))
        else if fromTime < lastMessagesFromTime
          toTime = new Date(Math.min(toTime, lastMessagesFromTime))

      @set('lastMessagesFromTime', fromTime)
      @set('lastMessagesToTime', toTime)

      @set('lastMessages', @find('message',
        from_time: fromTime.getTime() / 1000
        to_time: toTime.getTime() / 1000
        video_id: params.videoId
      ))

    @get('lastMessages')
