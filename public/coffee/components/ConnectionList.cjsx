UserStore = require '../stores/UserStore'
UserActions = require '../actions/UserActions'
User = require './User'
React = require 'react'

socket.on 'presence:update', (data)->
  UserActions.setUserPresences data

getStateFromStores = ->
  users: UserStore.getAll()

ConnectionList = React.createClass

  displayName: 'ConnectionList'

  getInitialState: ->
    getStateFromStores()

  componentDidMount: ->
    UserStore.addChangeListener @_onChange
    UserActions.getAll()

  createUserItem: (user) ->
    <User user={user} key={user.id}/>

  render: ->
    <div>
      <ul>{@state.users.map(@createUserItem)}</ul>
      <span onClick={@_start}>Start Presence Storm</span> |
      <span onClick={@_stop}>Stop Presence Storm</span>
    </div>
  
  #Event handler for 'change' events coming from the MessageStore
  _onChange: ->
    @setState getStateFromStores()

  _start: ->
    socket.emit 'start:presence:storm'

  _stop: ->
    socket.emit 'stop:presence:storm'

module.exports = ConnectionList