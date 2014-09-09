React = require 'react'
ConnectionList = require './components/ConnectionList'

require('react-raf-batching').inject()

React.renderComponent <ConnectionList users={[]} />, document.getElementById('connection-list')

# For React Developer Tools
window.React = React