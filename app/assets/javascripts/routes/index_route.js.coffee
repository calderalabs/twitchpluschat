Twitchpluschat.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo('channels')
