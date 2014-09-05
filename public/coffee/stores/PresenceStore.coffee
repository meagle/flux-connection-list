AppDispatcher = require("../dispatcher/AppDispatcher")
EventEmitter = require("events").EventEmitter
merge = require("react/lib/merge")

CHANGE_EVENT = "change"

_presences = {}

PresenceStore = merge(EventEmitter::,
  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (callback) ->
    @on CHANGE_EVENT, callback

  get: (userId)->
    _presences[userId] || 'offline'

)

PresenceStore.dispatchToken = AppDispatcher.register((payload) ->
  
  action = payload.action

  switch action.type
    when "UPDATE_PRESENCE"
      _presences[action.userId] = action.presence
      PresenceStore.emitChange()
      break

    when "UPDATE_PRESENCES"
      for userPresence in action.userPresences
        _presences[userPresence.userId] = userPresence.presence
      PresenceStore.emitChange()
      break
)

module.exports = PresenceStore

