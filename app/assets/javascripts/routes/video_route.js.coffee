Twitchpluschat.VideoRoute = Ember.Route.extend
  model: (params) ->
    @store.find('video', params.video_id).then (video) =>
      Ember.RSVP.hash
        video: video

        messages: @store.findMessages(
          videoId: video.get('id'),
          atTime: video.get('recordedAt')
        )

  setupController: (controller, model) ->
    controller.set('content', model.video)
    controller.set('messages', model.messages)
