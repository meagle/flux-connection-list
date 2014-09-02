`/** @jsx React.DOM */`

React = require 'react'
Promise = require 'bluebird'
request = Promise.promisify require 'request'
ConnectionList = require './components/ConnectionList.react'


request("http://localhost:3000/users").then((users)->

  # Silly data transformation to account for dummy-users values
  users.shift 0
  users = JSON.parse users
  React.renderComponent ConnectionList(users: users), document.getElementById('connection-list')

)