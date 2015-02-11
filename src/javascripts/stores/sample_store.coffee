Store =  require "./store"
Dispatcher = require "../dispatcher/app_dispatcher"
SampleConstants = require "../constants/sample_constants"

class SampleStore extends Store
  item: "this is what I have"

module.exports = SampleStore
