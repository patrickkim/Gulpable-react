React = require "react"
TestComponent = require "./components/test_component.cjsx"

App =
  initialize: (options) ->
    @_setup_components()

  _setup_components: ->
    React.render <TestComponent rad="work please?" />, $('#application')[0]

module.exports = App
