Twitchpluschat.VideoRoute = Ember.Route.extend
  model: (params) ->
    Ember.RSVP.hash
      video: @store.find('video', params.video_id)
      messages: @store.find('message', video_id: params.video_id)

  setupController: (controller, model) ->
    controller.set('content', model.video)
    controller.set('messages', model.messages)
