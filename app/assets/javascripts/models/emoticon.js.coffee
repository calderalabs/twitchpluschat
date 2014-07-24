Twitchpluschat.Video = DS.Model.extend
  width: DS.attr('number')
  height: DS.attr('number')
  url: DS.attr('string')
  regexp: Ember.computed.alias('id')
