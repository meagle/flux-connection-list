React = require 'react/addons'

Presence = React.createClass

  displayName: 'Presence'

  shouldComponentUpdate: (nextProps, nextState) ->
    nextProps.presence isnt @props.presence

  render: ->
    <span className={@_getPresenceClassName()}></span>
  
  _getPresenceClassName: ->
    React.addons.classSet
      presence: true
      online: @props.presence is "online"
      away: @props.presence is "away"
      offline: @props.presence is "offline"

module.exports = Presence