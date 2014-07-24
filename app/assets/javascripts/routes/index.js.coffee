Twitchpluschat.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo('channels')

Twitchpluschat.ChannelRoute = Ember.Route.extend
  model: (params) ->
    Ember.Object.create(id: params.channel_id)

Twitchpluschat.ChannelVideoRoute = Ember.Route.extend
  model: (params) ->
    Ember.RSVP.hash
      video: @store.find('video', "a#{params.video_id}")
      channelId: @modelFor('channel').get('id')
      messages: @store.find('message')

  setupController: (controller, model) ->
    controller.set('model', model.video)
    controller.set('channelId', model.channelId)
    controller.set('messages', model.messages)
