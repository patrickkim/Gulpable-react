{ EventEmitter } = require "events"
assign = require "object-assign"

Dispatcher = require "../dispatcher/app_dispatcher"
SampleConstants = require "../constants/sample_constants"

CHANGE_EVENT = "change"

class SampleStore
  CHANGE_EVENT: "change"
  
  @ping: ->


SampleStore = assign {}, EventEmitter::, {

  ping: (text) ->
    console.log "pinging", text

  pong: ->


  emitChange: ->
    @emit CHANGE_EVENT

}

Dispatcher.register (action) ->
  switch action.actionType
    when SampleConstants.PING
      SampleStore.ping("HI")
    when SampleConstants.PING
      SampleStore.pong("HI")

module.exports = SampleStore
