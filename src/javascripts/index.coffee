window.App = require "./app"
Store = require "./stores/sample_store"

$ ->
  # App.initialize()
  window.SampleStore = Store
  console.log "test store", SampleStore
