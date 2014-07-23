Twitchpluschat.PlayerView = Ember.View.extend
  templateName: 'views/player'

  twitchPlayerId: (->
    "#{@get('elementId')}-twitch-player"
  ).property('elementId')

  eventHandlerName: (->
    "onPlayerEvent#{@get('elementId')}"
  ).property('elementId')

  twitchPlayer: null

  updateVideoTime: ->
    twitchPlayer = @get('twitchPlayer')
    videoTime = twitchPlayer.getVideoTime()

    @set('controller.currentTime', videoTime) unless twitchPlayer.isPaused()

  startUpdatingVideoTime: ->
    Ember.run.later(
      this, (->
        @updateVideoTime()
        @startUpdatingVideoTime()
      ), 100
    )

  didInsertElement: ->
    @_super.apply(this, arguments)

    window[@get('eventHandlerName')] = (data) =>
      twitchPlayer = @get('twitchPlayer')

      Ember.run =>
        data.forEach (event) =>
          switch event.event
            when 'playerInit'
              twitchPlayer.playVideo()
            when 'videoPlaying'
              @startUpdatingVideoTime()

    swfobject.embedSWF(
      '//www-cdn.jtvnw.net/swflibs/TwitchPlayer.swf',
      @get('twitchPlayerId'),
      '640', '400', '11', null,

      {
        eventsCallback: @get('eventHandlerName')
        embed: 1
        channel: @get('controller.channelId')
        archive_id: @get('controller.id')
        auto_play: true
      },

      {
        allowScriptAccess: 'always'
        allowFullScreen: true
      },

      null,
      => @set('twitchPlayer', @$("##{@get('twitchPlayerId')}")[0])
    )

    willDestroyElement: ->
      @_super.apply(this, arguments)

      delete window[@get('eventHandlerName')]
      Ember.run.cancel(this, updateVideoTime)
