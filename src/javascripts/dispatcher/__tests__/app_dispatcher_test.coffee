'use strict'
jest.autoMockOff()

describe 'AppDispatcher', ->

  AppDispatcher = undefined

  beforeEach ->
    AppDispatcher = require "../app_dispatcher.coffee"

  it 'sends actions to subscribers', ->
    listener = jest.genMockFunction()
    AppDispatcher.register listener
    payload = {}
    AppDispatcher.dispatch payload
    expect(listener.mock.calls.length).toBe 1
    expect(listener.mock.calls[0][0]).toBe payload

  it 'waits with chained dependencies properly', ->
    payload = {}
    listener1Done = false

    listener1 = (pl) ->
      AppDispatcher.waitFor [
        index2
        index4
      ]

      # Second, third, and fourth listeners should have now been called
      expect(listener2Done).toBe true
      expect(listener3Done).toBe true
      expect(listener4Done).toBe true
      listener1Done = true

    index1 = AppDispatcher.register(listener1)
    listener2Done = false

    listener2 = (pl) ->
      AppDispatcher.waitFor [ index3 ]
      expect(listener3Done).toBe true
      listener2Done = true

    index2 = AppDispatcher.register(listener2)
    listener3Done = false

    listener3 = (pl) ->
      listener3Done = true
      return

    index3 = AppDispatcher.register(listener3)
    listener4Done = false

    listener4 = (pl) ->
      AppDispatcher.waitFor [ index3 ]
      expect(listener3Done).toBe true
      listener4Done = true

    index4 = AppDispatcher.register(listener4)

    runs ->
      AppDispatcher.dispatch payload

    waitsFor (->
      listener1Done
    ), 'Not all subscribers were properly called', 500

    runs ->
      expect(listener1Done).toBe true
      expect(listener2Done).toBe true
      expect(listener3Done).toBe true
