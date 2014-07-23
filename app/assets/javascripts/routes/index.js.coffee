Twitchpluschat.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo('channels')

Twitchpluschat.ChannelRoute = Ember.Route.extend
  model: ->
    Ember.Object.create()

Twitchpluschat.ChannelVideoRoute = Ember.Route.extend
  model: ->
    Ember.Object.create()
