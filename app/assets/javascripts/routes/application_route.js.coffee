Twitchpluschat.ApplicationRoute = Ember.Route.extend
  activate: ->
    Ember.$.getJSON('/emoticon_sets').then (payload) =>
      model = payload.emoticon_sets.reduce(((memo, set) ->
        memo[set.id] = set.emoticons
        memo
      ), {})

      @controllerFor('emoticonSets').set('content', model)
