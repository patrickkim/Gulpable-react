React = require "react"
test_model = require "./models/test"
TestComponent = require "./components/test_component.cjsx"

App =
  initialize: (options) ->
    @_setup_models(options)
    @_setup_components()

  _setup_models: (options) ->
    console.log "please work!!!@!@!"
    @test = new test_model()
    console.log "testing model, ping", @test.get("ping")

  _setup_components: ->
    React.render <TestComponent rad="work please?" />, $('#application')[0]

module.exports = App
