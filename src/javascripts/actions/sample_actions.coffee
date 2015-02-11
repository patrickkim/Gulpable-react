Dispatcher = require "../dispatcher/app_dispatcher"
SampleConstants = require "../dispatcher/sample_constants"

class SampleActions
  @ping: (text) ->
    Dispatcher.dispatch
      actionType: SampleConstants.PING
      text: text
    return

  @pong: ->
    Dispatcher.dispatch
      actionType: SampleConstants.PONG
      pong: { value: "pong" }

module.exports = SampleActions
