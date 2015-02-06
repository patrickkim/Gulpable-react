Backbone = require "backbone"

class Test extends Backbone.Model

  initialize: (options) ->
    @set(ping: "pong")

module.exports = Test
