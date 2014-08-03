Twitchpluschat.ApplicationStore = DS.Store.extend
  BatchSeconds: 60

  lastMessages: null
  lastInterval: null

  findMessages: (params) ->
    interval = Twitchpluschat.TimeInterval.interval(
      center: params.atTime
      min: params.minTime
      seconds: @get('BatchSeconds')
    )

    lastInterval = @get('lastInterval')
    isCached = lastInterval? && lastInterval.hasDate(interval.get('center'))

    unless isCached
      if lastInterval?
        interval.subtract(lastInterval)

      @set('lastInterval', interval)

      @set('lastMessages', @find('message',
        from_time: interval.get('from').getTime() / 1000
        to_time: interval.get('to').getTime() / 1000
        video_id: params.videoId
      ))

    @get('lastMessages')
