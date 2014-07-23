#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require swfobject
#= require twitchpluschat
#= require_self
#= require_tree ./templates
#= require router
#= require models
#= require controllers
#= require routes
#= require views

Twitchpluschat.ApplicationStore = DS.Store.extend
  namespace: 'api'
  host: 'http://localhost:3000'

Twitchpluschat.ApplicationAdapter = DS.FixtureAdapter.extend()
Twitchpluschat.ApplicationSerializer = DS.ActiveModelSerializer.extend()
