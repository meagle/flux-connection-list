AppDispatcher = require("../dispatcher/AppDispatcher")
EventEmitter = require("events").EventEmitter
merge = require("react/lib/merge")
Promise = require 'bluebird'
request = Promise.promisify require 'request'

CHANGE_EVENT = "change"

_users = []
_selected = -1

UserStore = merge(EventEmitter::,
  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  getAll: ->
    _users

  getSelected: ->
    _selected
)

UserStore.dispatchToken = AppDispatcher.register((payload) ->
  
  action = payload.action

  switch action.type
    when "RECEIVE_ALL_USERS"

      request("http://localhost:3000/users").then((users)->
        # Silly data transformation to account for dummy-users values
        users.shift 0
        _users = JSON.parse users
        UserStore.emitChange()
      )

    # when "SELECT_NODE"
    #   _selected = action.key
    #   UserStore.emitChange()

    # when "NEXT_VISIBLE_NODE"
    #   _selected = _selected + 1  unless typeof _selected is "undefined"
    #   console.log "just simple increase:" + _selected
    #   UserStore.emitChange()

    # when "PREVIOUS_VISIBLE_NODE"
    #   _selected = _selected - 1  unless typeof _selected is "undefined"
    #   console.log "just simple decrease:" + _selected
    #   UserStore.emitChange()

    # when "TOGGLE_COLLAPSE_NODE"
    #   _nodes.collapsed = not _nodes.collapsed
    #   console.log "toggling collapse on key:" + _selected
    #   UserStore.emitChange()
)

module.exports = UserStore