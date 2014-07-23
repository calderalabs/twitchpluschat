#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require swfobject
#= require_tree .

CHANNEL_MESSAGES = [
  'Hey there',
  'How are you doing brah',
  'Kappa',
  'Lappa',
  'Keepo'
]

$ ->
  player = null
  lastVideoTime = 0
  messages = []

  $messages = $('.messages')

  removeFutureMessages = (videoTime) ->
    messages.slice(0).forEach (message, index) ->
      timeStamp = index * 100

      if videoTime < timeStamp
        messages.splice(index, 1)
        $messages.find("li:nth-child(#{index + 1})").remove()

  addPastMessages = (videoTime) ->
    CHANNEL_MESSAGES.forEach (message, index) ->
      timeStamp = index * 100

      if timeStamp < videoTime && messages.indexOf(message) == -1
        messages.push(message)
        $messages.append("<li>#{message}</li>")

  updateChat = ->
    return if player.isPaused()
    videoTime = player.getVideoTime()

    if videoTime < lastVideoTime
      removeFutureMessages(videoTime)
    else if videoTime > lastVideoTime
      addPastMessages(videoTime)

    lastVideoTime = videoTime

  startRunLoop = ->
    setInterval(updateChat, 100)

  window.onTwitchPlayerEvent = (data) ->
    data.forEach (event) ->
      switch event.event
        when 'playerInit'
          player.playVideo()
        when 'videoPlaying'
          startRunLoop()

  swfobject.embedSWF(
    '//www-cdn.jtvnw.net/swflibs/TwitchPlayer.swf',
    'twitch_player',
    '640', '400', '11', null,

    {
      eventsCallback: 'onTwitchPlayerEvent'
      embed: 1
      channel: 'arteezy'
      archive_id: 543686965
      auto_play: true
    },

    {
      allowScriptAccess: 'always'
      allowFullScreen: true
    },

    null,
    -> player = $('#twitch_player')[0]
  )
