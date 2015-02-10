React = require "react"

class RadComponent extends React.Component

  propTypes: {}
  mixins : []

  getInitialState: ->
    console.log "set intial state here"

  getDefaultProps: ->
    console.log "set intial props here"

  componentWillMount: ->
    false

  componentWillReceiveProps: ->
    false

  componentWillUnmount: ->
    false

  shouldComponentUpdate: (nextProps, nextState) ->
    true
    
  render: ->
    <div className="rad-component">
      <p>is this component rad? {@props.rad}</p>
    </div>

  _parseData: ->


  _onSelect: ->


module.exports = RadComponent
