Twitchpluschat.ApplicationStore = DS.Store.extend
  BatchSeconds: 60

  lastBatch: null
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

      @set('lastBatch', @find('message',
        from_time: interval.get('from').getTime() / 1000
        to_time: interval.get('to').getTime() / 1000
        video_id: params.videoId
      ).then (batch) -> batch.toArray().sortBy('sentAt'))

    @get('lastBatch')
