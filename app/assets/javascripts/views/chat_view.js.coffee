Twitchpluschat.ChatView = Ember.View.extend
  templateName: 'chat'

  didInsertMessage: ->
    container = @$('.chat')
    container.scrollTop(container.prop('scrollHeight'))
