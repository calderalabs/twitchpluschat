Twitchpluschat.Emoticon = DS.Model.extend
  width: DS.attr('number')
  height: DS.attr('number')
  url: DS.attr('string')

  regexp: (->
    new RegExp(@get('id'), 'g')
  ).property('id')
