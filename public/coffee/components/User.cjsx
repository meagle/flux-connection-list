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
      <div className="avatar">
        {@props.user.firstName.charAt(0)}{@props.user.lastName.charAt(0)}
      </div>
      <span>{@props.user.firstName} {@props.user.lastName}</span> <span className="user-id">{@props.user.id}</span>
      <Presence presence={@props.user.presence}/>
    </li>

module.exports = User


