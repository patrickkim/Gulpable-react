alt = require "../utils/alt"

class SampleActions

  constructor: ->
    @generateActions "upvote", "update"

  # upvote: (text) ->
  #   @dispatch(text)

module.exports = alt.createActions(SampleActions)
