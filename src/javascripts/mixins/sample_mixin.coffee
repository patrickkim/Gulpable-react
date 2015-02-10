SampleMixin = {
  componentWillMount: ->
    @_ping()

  _ping: ->
    console.log "pong", @state

}

module.exports = SampleMixin
