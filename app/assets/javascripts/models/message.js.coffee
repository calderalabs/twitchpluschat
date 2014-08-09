Twitchpluschat.Message = DS.Model.extend
  userName: DS.attr('string')
  text: DS.attr('string')
  sentAt: DS.attr('date')
  emoticonSetIds: DS.attr('raw')
  color: DS.attr('string')
  channelId: DS.attr('string')
  rawText: DS.attr('string')
