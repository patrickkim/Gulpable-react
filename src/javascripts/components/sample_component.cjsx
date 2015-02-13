React = require "react"
SampleStore = require "../stores/sample_store"
SampleActions = require "../actions/sample_actions"

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
    @state = { sum:  SampleStore.sum() }
    console.log "with state:", @state

  componentDidMount: ->
    SampleStore.listen(@onChange)

  componentWillUnmount: ->
    SampleStore.unlisten(@onChange)

  # componentWillMount: ->

  # Drop in when using immutable.
  # shouldComponentUpdate: (nextProps, nextState) ->

  onChange: =>
    @setState(sum: SampleStore.sum())

  upvote: ->
    SampleActions.upvote(1)


  render: ->
    <div className="sample-component">
      <div id="thumb" onClick={@upvote}></div>
      <p>Votes: {@state.sum} </p>
    </div>

module.exports = SampleComponent
