Twitchpluschat.ApplicationRoute = Ember.Route.extend
  activate: ->
    @store.find('emoticonSet').then (sets) =>
      @controllerFor('emoticonSets').set('content', sets)
