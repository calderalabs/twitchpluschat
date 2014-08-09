Twitchpluschat.Channel = DS.Model.extend
  videos: DS.hasMany('video')
  name: DS.attr('string')
  delay: DS.attr('number')
  url: DS.attr('string')
