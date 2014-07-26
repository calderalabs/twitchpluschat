Twitchpluschat.MessageController = Ember.ObjectController.extend
  needs: ['emoticonSets']
  emoticonSets: Ember.computed.alias('controllers.emoticonSets')

  textPartClass: Ember.ObjectProxy.extend
    type: 'text'

  emoticonPartClass: Ember.ObjectProxy.extend
    type: 'emoticon'

  matchingEmoticons: (->
    text = @get('text')
    emoticonSetIds = @get('emoticonSetIds')
    emoticonSets = @get('emoticonSets')

    matchingSets = emoticonSets.filter (set) ->
      id = set.get('id')
      id == 'default' || emoticonSetIds.indexOf(id) != -1

    matchingEmoticons = matchingSets.reduce(((memo, set) ->
      memo.push.apply(memo, set.get('emoticons').toArray())
      memo
    ), [])

    matchingEmoticons.filter (emoticon) ->
      text.match(emoticon.get('regexp'))
  ).property('emoticonSets', 'text')

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
