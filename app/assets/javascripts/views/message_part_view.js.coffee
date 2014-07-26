Twitchpluschat.MessagePartView = Ember.View.extend
  tagName: 'span'

  templateName: (->
    "message/#{@get('controller.type')}"
  ).property('controller.type')
