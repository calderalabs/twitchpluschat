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
#= require serializers
#= require adapters
#= require models
#= require controllers
#= require routes
#= require views

Twitchpluschat.ApplicationStore = DS.Store.extend()

Twitchpluschat.ApplicationAdapter = DS.ActiveModelAdapter.extend
  namespace: 'api'
  host: 'http://localhost:3000'

Twitchpluschat.ApplicationSerializer = DS.ActiveModelSerializer.extend()
