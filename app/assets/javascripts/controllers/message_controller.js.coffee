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
    emoticonSets = @get('emoticonSets.content')
    userSets = [emoticonSets['default']]

    for setId in emoticonSetIds
      set = emoticonSets[setId]
      userSets.push(set) if set?

    matchingEmoticons = []

    for emoticon in _(userSets).flatten(true)
      if text.match(new RegExp(emoticon.regexp, 'g'))
        matchingEmoticons.push(emoticon)

    matchingEmoticons
  ).property('emoticonSets', 'text')

  parts: (->
    textPartClass = @get('textPartClass')
    emoticonPartClass = @get('emoticonPartClass')

    emoticonizeText = (text, emoticon) ->
      components = text.split(new RegExp(emoticon.regexp, 'g'))

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

  userNameStyle: (->
    color = @get('color')

    if color?
      "color: #{color}"
    else
      null
  ).property('color')

  isBroadcasted: (->
    @get('userName') == 'jtv'
  ).property('userName')

  showUserName: (->
    !@get('isBroadcasted')
  ).property('isBroadcasted')
