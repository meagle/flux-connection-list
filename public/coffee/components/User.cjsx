UserStore = require '../stores/UserStore'
Presence = require './Presence'
React = require 'react/addons'

User = React.createClass

  displayName: 'User'

  # componentWillReceiveProps: (newProps)->
    # console.log 'componentWillReceiveProps', newProps.user.presence, @props.user.presence

  shouldComponentUpdate: (nextProps, nextState)->
    # console.log nextProps.user.presence, @props.user.presence
    # true
    nextProps.user isnt @props.user

  render: ->
    <li>
      <span>{@props.user.firstName} {@props.user.lastName} - {@props.user.id}</span>
      <Presence presence={@props.user.presence}/>
    </li>

module.exports = User


