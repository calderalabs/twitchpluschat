Twitchpluschat.ApplicationRoute = Ember.Route.extend
  activate: ->
    Ember.$.getJSON('/emoticon_sets').then (payload) =>
      @controllerFor('emoticonSets').set('content', payload.emoticon_sets)
