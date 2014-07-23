#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require swfobject
#= require_tree .

MESSAGES = [
  'Hey there',
  'How are you doing brah',
  'Kappa',
  'Lappa',
  'Keepo'
]

$ ->
  player = null
  lastVideoTime = 0

  removeFutureMessages = (->)
  addPastMessages = (->)

  updateChat = ->
    return if player.isPaused()
    videoTime = player.getVideoTime()

    if videoTime < lastVideoTime
      removeFutureMessages()
    else if videoTime > lastVideoTime
      addPastMessages()

  startRunLoop = ->
    updateChat()
    setTimeout(startRunLoop, 100)

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
