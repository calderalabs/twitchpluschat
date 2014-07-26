Twitchpluschat.ChannelRoute = Ember.Route.extend
  model: (params) ->
    Ember.Object.create(id: params.channel_id)
