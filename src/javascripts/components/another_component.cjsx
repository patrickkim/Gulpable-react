React = require "react"
SampleMixin = require "../mixins/sample_mixin"

AnotherComponent = React.createClass

  mixins: [SampleMixin]

  getDefaultProps: ->
    { initial_seconds: 10 }

  getInitialState: ->
    { seconds: @props.initial_seconds }

  render: ->
    <p>
      React has been running for {@state.seconds} seconds.
    </p>

module.exports = AnotherComponent
