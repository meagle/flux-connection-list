React = require 'react'
ConnectionList = require './components/ConnectionList'

React.renderComponent <ConnectionList users={[]} />, document.getElementById('connection-list')

# For React Developer Tools
window.React = React