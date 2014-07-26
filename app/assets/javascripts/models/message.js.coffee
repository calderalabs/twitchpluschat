Twitchpluschat.Message = DS.Model.extend
  userId: DS.attr('string')
  text: DS.attr('string')
  createdAt: DS.attr('date')
