Twitchpluschat.Video = DS.Model.extend
  channel: DS.belongsTo('channel')
  recordedAt: DS.attr('date')
  title: DS.attr('string')
