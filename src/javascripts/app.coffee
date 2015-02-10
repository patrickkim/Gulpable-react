React = require "react"
SampleComponent = require "./components/sample_component.cjsx"
AnotherComponent = require "./components/another_component.cjsx"

App =
  initialize: (options) ->
    @_setup_components()

  _setup_components: ->
    React.render <SampleComponent another_thing="work please?" />, $('#application')[0]
    React.render <AnotherComponent />, $('#pip')[0]

module.exports = App
