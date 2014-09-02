`/** @jsx React.DOM */`

React = require 'react'

getStateFromStores = ->
  # nodes: OutlineStore.getAll()
  # selected: OutlineStore.getSelected()

# OutlineStore = require("../stores/OutlineStore")
# Node = require("./Node.react")


ConnectionList = React.createClass
  getInitialState: ->
    # TODO: get state from stores instead of passing it down from app.coffee
    # getStateFromStores()
    users: @props.users

  componentDidMount: ->
    # OutlineStore.addChangeListener @_onChange

  createUserItem: (user) ->
    `<li key={user.id}>{user.firstName}</li>`

  render: ->
    # rootNode = @state.nodes
    # selected = @state.selected
    
    `<ul>{this.props.users.map(this.createUserItem)}</ul>`

  
  #Event handler for 'change' events coming from the MessageStore
  # _onChange: ->
  #   @setState getStateFromStores()

module.exports = ConnectionList