Twitchpluschat.ApplicationStore = DS.Store.extend
  TimeInterval: 20

  lastFromTime: null
  lastMessages: null

  findMessages: (params) ->
    TimeInterval = @get('TimeInterval')

    if params.fromTime?
      fromTime = new Date(params.fromTime)
      fromTime.setSeconds(fromTime.getSeconds() - (fromTime.getSeconds() % TimeInterval))
      lastFromTime = @get('lastFromTime')

      return @get('lastMessages') if lastFromTime? && fromTime.getTime() == lastFromTime.getTime()
      @set('lastFromTime', fromTime)

      toTime = new Date(fromTime)
      toTime.setSeconds(toTime.getSeconds() + TimeInterval)

      query =
        from_time: fromTime.getTime() / 1000
        to_time: toTime.getTime() / 1000
        video_id: params.videoId

    messages = @find('message', query)
    @set('lastMessages', messages)
    messages
