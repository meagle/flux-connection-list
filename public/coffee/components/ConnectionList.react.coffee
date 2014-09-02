`/** @jsx React.DOM */`

UserStore = require '../stores/UserStore'
UserActions = require '../actions/UserActions'
React = require 'react'

getStateFromStores = ->
  users: UserStore.getAll()

ConnectionList = React.createClass
  getInitialState: ->
    getStateFromStores()

  componentDidMount: ->
    UserStore.addChangeListener @_onChange
    UserActions.getAll()

  createUserItem: (user) ->
    `<li key={user.id}>{user.firstName}</li>`

  render: ->
    `<ul>{this.state.users.map(this.createUserItem)}</ul>`
  
  #Event handler for 'change' events coming from the MessageStore
  _onChange: ->
    @setState getStateFromStores()

module.exports = ConnectionList