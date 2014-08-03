Twitchpluschat.MessageView = Ember.View.extend
  templateName: 'message'
  chatView: null

  didInsertElement: ->
    @get('chatView').didInsertMessage(this)
