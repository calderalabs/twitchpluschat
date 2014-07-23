Twitchpluschat.ChannelVideoController = Ember.ObjectController.extend
  videoTime: null

  visibleMessages: (->
    @get('messages')
  ).property('messages')
