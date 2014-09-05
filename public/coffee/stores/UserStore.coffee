AppDispatcher     = require("../dispatcher/AppDispatcher")
EventEmitter      = require("events").EventEmitter
merge             = require("react/lib/merge")
PresenceStore     = require '../stores/PresenceStore'
Promise           = require 'bluebird'
_                 = require 'underscore'
request           = Promise.promisify require 'request'

CHANGE_EVENT = "change"

_users = []
_selected = -1

UserStore = merge(EventEmitter::,
  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  getAll: ->
    _.sortBy _users, (user)-> [user.presence, user.firstName, user.lastName]

  getSelected: ->
    _selected

  updateUserById: (id, properties) ->
    foundIndex = null
    _users.forEach (user, index) ->
      if user.id is id
        foundIndex = index
      return

    user = _users[foundIndex]

    newUser = _.extend {}, user, properties

    _users[foundIndex] = newUser
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
      break
    
    when "UPDATE_PRESENCE"

      AppDispatcher.waitFor [PresenceStore.dispatchToken]
      
      userId   = action.userId
      presence = PresenceStore.get userId
      UserStore.updateUserById userId, presence: presence

      UserStore.emitChange()
      break

    when "UPDATE_PRESENCES"

      AppDispatcher.waitFor [PresenceStore.dispatchToken]
      
      for userPresence in action.userPresences
        userId   = userPresence.userId
        presence = PresenceStore.get userId
        UserStore.updateUserById userId, presence: presence
      
      UserStore.emitChange()
      break
)

module.exports = UserStore