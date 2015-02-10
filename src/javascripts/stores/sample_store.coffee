AppDispatcher = require('../dispatcher/AppDispatcher')
EventEmitter = require('events').EventEmitter
# TodoConstants = require('../constants/TodoConstants')
assign = require('object-assign')
CHANGE_EVENT = 'change'

_todos = {}

TodoStore = assign({}, EventEmitter.prototype,

  areAllComplete: ->
    for id of _todos
      if !_todos[id].complete
        return false
    true

  getAll: ->
    _todos

  emitChange: ->
    @emit CHANGE_EVENT
    return

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback
    return

  removeChangeListener: (callback) ->
    @removeListener CHANGE_EVENT, callback
    return
)
# Register callback to handle all updates

###*
# Create a TODO item.
# @param  {string} text The content of the TODO
###

create = (text) ->
  # Hand waving here -- not showing how this interacts with XHR or persistent
  # server-side storage.
  # Using the current timestamp + random number in place of a real id.
  id = (+new Date + Math.floor(Math.random() * 999999)).toString(36)
  _todos[id] =
    id: id
    complete: false
    text: text
  return

###*
# Update a TODO item.
# @param  {string} id
# @param {object} updates An object literal containing only the data to be
#     updated.
###

update = (id, updates) ->
  _todos[id] = assign({}, _todos[id], updates)
  return

###*
# Update all of the TODO items with the same object.
#     the data to be updated.  Used to mark all TODOs as completed.
# @param  {object} updates An object literal containing only the data to be
#     updated.

###

updateAll = (updates) ->
  for id of _todos
    update id, updates
  return

###*
# Delete a TODO item.
# @param  {string} id
###

destroy = (id) ->
  delete _todos[id]
  return

###*
# Delete all the completed TODO items.
###

destroyCompleted = ->
  for id of _todos
    if _todos[id].complete
      destroy id
  return

AppDispatcher.register (action) ->
  text = undefined
  switch action.actionType
    when TodoConstants.TODO_CREATE
      text = action.text.trim()
      if text != ''
        create text
      TodoStore.emitChange()
    when TodoConstants.TODO_TOGGLE_COMPLETE_ALL
      if TodoStore.areAllComplete()
        updateAll complete: false
      else
        updateAll complete: true
      TodoStore.emitChange()
    when TodoConstants.TODO_UNDO_COMPLETE
      update action.id, complete: false
      TodoStore.emitChange()
    when TodoConstants.TODO_COMPLETE
      update action.id, complete: true
      TodoStore.emitChange()
    when TodoConstants.TODO_UPDATE_TEXT
      text = action.text.trim()
      if text != ''
        update action.id, text: text
      TodoStore.emitChange()
    when TodoConstants.TODO_DESTROY
      destroy action.id
      TodoStore.emitChange()
    when TodoConstants.TODO_DESTROY_COMPLETED
      destroyCompleted()
      TodoStore.emitChange()
    # no op
  return

module.exports = TodoStore
