Ember.Router.reopen
  location: 'auto'

Ember.Router.map ->
  @resource 'channels', path: '/channels', ->
    @resource 'channel', path: ':channel_id', ->
      @route 'video', path: 'videos/:video_id'
