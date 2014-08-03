Twitchpluschat.Message = DS.Model.extend
  userName: DS.attr('string')
  text: DS.attr('string')
  createdAt: DS.attr('date')
  emoticonSetIds: DS.attr('raw')
  color: DS.attr('string')
