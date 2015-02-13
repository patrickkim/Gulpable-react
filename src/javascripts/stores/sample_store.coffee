alt           = require "../utils/alt"
SampleActions = require "../actions/sample_actions"
_ = require "lodash"

class SampleStore

  constructor: ->
    # @bindAction(SampleActions.UPVOTE, @onUPVOTE)
    @bindActions(SampleActions)

    @stored_data = [100]

  onUpvote: (upvote) ->
    @stored_data.push(upvote)
    console.log "update me!", @stored_data

  # publicly available?
  @sum: ->
    _(@_accessor()).reduce (sum, i) -> sum + i

  @_accessor: ->
    @getState().stored_data

module.exports = alt.createStore(SampleStore, "HelloMom")
