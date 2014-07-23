#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require swfobject
#= require twitchpluschat
#= require_self
#= require router
#= require_tree ./templates
#= require_tree ./initializers
#= require models
#= require controllers
#= require routes
#= require views

Twitchpluschat.ApplicationStore = DS.Store.extend
  namespace: 'api'
  host: 'http://localhost:3000'

Twitchpluschat.ApplicationAdapter = DS.ActiveModelAdapter.extend()
Twitchpluschat.ApplicationSerializer = DS.ActiveModelSerializer.extend()
Twitchpluschat.MessageAdapter = DS.FixtureAdapter.extend()
