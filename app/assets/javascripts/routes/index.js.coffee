Twitchpluschat.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo('channels')

Twitchpluschat.ChannelRoute = Ember.Route.extend
  model: (params) ->
    Ember.Object.create(id: params.channel_id)

Twitchpluschat.ChannelVideoRoute = Ember.Route.extend
  model: (params) ->
    Ember.RSVP.hash
      id: params.video_id
      channelId: @modelFor('channel').get('id')
      messages: @store.all('message')
