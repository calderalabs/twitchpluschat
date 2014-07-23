Twitchpluschat.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo('channels')

Twitchpluschat.ChannelRoute = Ember.Route.extend
  model: (params) ->
    Ember.Object.create(id: params.channel_id)

Twitchpluschat.ChannelVideoRoute = Ember.Route.extend
  findVideo: (id) ->
    new Ember.RSVP.Promise (resolve, reject) =>
      Twitch.api { method: "videos/a#{id}" }, (error, data) =>
        if error?
          reject(error)
        else
          data.id = data._id.substring(1)
          @store.pushPayload('video', videos: [data])
          resolve(@store.find('video', id))

  model: (params) ->
    Ember.RSVP.hash
      video: @findVideo(params.video_id)
      channelId: @modelFor('channel').get('id')
      messages: @store.find('message')

  setupController: (controller, model) ->
    controller.set('model', model.video)
    controller.set('channelId', model.channelId)
    controller.set('messages', model.messages)
