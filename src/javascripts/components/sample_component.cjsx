React = require "react"

class SampleComponent extends React.Component

  #type setting
  @propTypes =
    another_thing: React.PropTypes.string
    initial_count: React.PropTypes.number

  # Set default property
  @defaultProps = {
    another_thing: "doomed"
    initial_count: 0
  }

  # Set default state
  constructor: (props) ->
    @state = { count: props.initial_count }

  increment_count: =>
    console.log @state
    @setState(count: @state.count + 1)

# Drop in when using immutable.
# shouldComponentUpdate: (nextProps, nextState) ->

  componentWillMount: ->
    console.log "oyoooo", @state
    console.log "about to mount get your shit together!", @props

  componentDidMount: ->
    console.log "yay mounted!!!"

  render: ->
    <div className="sample-component">
      <div id="thumb" onClick={@increment_count}></div>
      <p>Propertys: {@props.another_thing} or {@state.count} || State: {@state.count} </p>
    </div>

module.exports = SampleComponent
