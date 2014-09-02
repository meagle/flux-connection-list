AppDispatcher = require("../dispatcher/AppDispatcher")

module.exports = 

  getAll: ->
    AppDispatcher.handleServerAction
      type: "RECEIVE_ALL_USERS"
