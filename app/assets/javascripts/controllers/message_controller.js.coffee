Twitchpluschat.MessageController = Ember.ObjectController.extend
  needs: ['emoticons']
  emoticons: Ember.computed.alias('controllers.emoticons')

  textPartClass: Ember.ObjectProxy.extend
    type: 'text'

  emoticonPartClass: Ember.ObjectProxy.extend
    type: 'emoticon'

  matchingEmoticons: (->
    text = @get('text')

    @get('emoticons').filter (emoticon) ->
      text.match(emoticon.get('regexp'))
  ).property('emoticons.@each.regexp', 'text')

  parts: (->
    textPartClass = @get('textPartClass')
    emoticonPartClass = @get('emoticonPartClass')

    emoticonizeText = (text, emoticon) ->
      components = text.split(emoticon.get('regexp'))

      components.reduce(((memo, component, index) ->
        isLastComponent = index == components.length - 1

        memo.push(textPartClass.create(content: component))
        memo.push(emoticonPartClass.create(content: emoticon)) unless isLastComponent

        memo
      ), [])

    emoticonizeParts = (parts, emoticon) ->
      parts.reduce(((memo, part) ->
        if part.get('type') == 'text'
          emoticonizeText(part.get('content'), emoticon).forEach((p) -> memo.push(p))
        else
          memo.push(part)

        memo
      ), [])

    @get('matchingEmoticons').reduce(
      ((memo, emoticon) -> emoticonizeParts(memo, emoticon)),
      [textPartClass.create(content: @get('text'))]
    )
  ).property('text', 'matchingEmoticons', 'textPartClass', 'emoticonPartClass')
