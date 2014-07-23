Twitchpluschat.initializer
  name: 'twitch',

  initialize: ->
    Twitchpluschat.deferReadiness()

    Twitch.init { clientId: '50yklplgktsrxbvyigawaqj0mtf6zys' }, ->
      Twitchpluschat.advanceReadiness()
