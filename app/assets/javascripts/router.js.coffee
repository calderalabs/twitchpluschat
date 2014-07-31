Ember.Router.reopen
  location: 'auto'

Ember.Router.map ->
  @route 'video', path: ':channel_id/b/:video_id'
