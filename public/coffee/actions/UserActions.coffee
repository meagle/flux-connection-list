AppDispatcher = require("../dispatcher/AppDispatcher")

module.exports = 

  getAll: ->
    AppDispatcher.handleServerAction
      type: "RECEIVE_ALL_USERS"

  setUserPresence: (userId, presence)->
    AppDispatcher.handleServerAction
      type: "UPDATE_PRESENCE"
      userId: userId
      presence: presence

  setUserPresences: (userPresences)->
    AppDispatcher.handleServerAction
      type: "UPDATE_PRESENCES"
      userPresences: userPresences
