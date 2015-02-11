{ EventEmitter } = require "events"

class Store extends EventEmitter

  @constructor: ->
    console.log "spinning up."
    super

  @prop: "erty"

  prop: {
    hello: "world"
  }


  ping: ->
    "pong"

module.exports = Store
