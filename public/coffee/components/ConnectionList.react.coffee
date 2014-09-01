`/** @jsx React.DOM */`

React = require 'react'

getStateFromStores = ->
  # nodes: OutlineStore.getAll()
  # selected: OutlineStore.getSelected()

# OutlineStore = require("../stores/OutlineStore")
# Node = require("./Node.react")


ConnectionList = React.createClass
  getInitialState: ->
    getStateFromStores()

  componentDidMount: ->
    # OutlineStore.addChangeListener @_onChange
    return

  render: ->
    # rootNode = @state.nodes
    # selected = @state.selected
    return `<span>Hello World!!!</span>`

  
  #Event handler for 'change' events coming from the MessageStore
  # _onChange: ->
  #   @setState getStateFromStores()

module.exports = ConnectionList