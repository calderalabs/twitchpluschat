Twitchpluschat.TwitchAdapter = DS.ActiveModelAdapter.extend
  defaultSerializer: 'twitch',

  ajax: (url, type, hash) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      Twitch.api { method: url }, (error, payload) =>
        if error?
          reject(error)
        else
          resolve(payload)
