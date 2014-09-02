`/** @jsx React.DOM */`

React = require 'react'
ConnectionList = require './components/ConnectionList.react'


React.renderComponent ConnectionList(users: []), document.getElementById('connection-list')
