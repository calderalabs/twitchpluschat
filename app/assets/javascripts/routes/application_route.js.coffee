Twitchpluschat.ApplicationRoute = Ember.Route.extend
  activate: ->
    @store.find('emoticon').then (emoticons) =>
      @controllerFor('emoticons').set('content', emoticons)
