minDate = (a, b) ->
  new Date(Math.min(a.getTime(), b.getTime()))

maxDate = (a, b) ->
  new Date(Math.max(a.getTime(), b.getTime()))

addSecondsToDate = (date, seconds) ->
  new Date(date.getTime() + seconds * 1000)

Twitchpluschat.TimeInterval = Ember.Object.extend
  from: null
  to: null

  center: (->
    new Date(Math.floor((@get('from').getTime() + @get('to').getTime()) / 2))
  ).property('from', 'to')

  hasDate: (date) ->
    date >= @get('from') && date <= @get('to')

  subtract: (interval) ->
    to = @get('to')
    from = @get('from')
    otherTo = interval.get('to')
    otherFrom = interval.get('from')

    if to  > otherTo
      @set('from', maxDate(from, otherTo))
    else if from < otherFrom
      @set('to', minDate(to, otherFrom))

Twitchpluschat.TimeInterval.reopenClass
  interval: (options) ->
    center = options.center ? new Date()
    min = options.min ? center
    seconds = options.seconds
    from = addSecondsToDate(center, -seconds / 2)
    to = addSecondsToDate(center, seconds / 2)

    @create(from: maxDate(from, min), to: maxDate(to, min))
