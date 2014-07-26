Twitchpluschat.ChannelVideoRoute = Ember.Route.extend
  model: (params) ->
    Ember.RSVP.hash
      video: @store.find('video', params.video_id)
      channelId: @modelFor('channel').get('id')
      messages: @store.find('message')

  setupController: (controller, model) ->
    controller.set('content', model.video)
    controller.set('channelId', model.channelId)
    controller.set('messages', model.messages)
