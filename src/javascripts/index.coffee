window.App = require "./app"
keyMirror = require('react/lib/keymirror')
COLORS = keyMirror(blue: null, red: null)

stores = require "./stores/sample_store"

$ ->
  App.initialize()
  console.log "testing", COLORS
