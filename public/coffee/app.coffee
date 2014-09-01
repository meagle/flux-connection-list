React = require 'react'
Promise = require 'bluebird'
request = Promise.promisify require 'request'
ConnectionList = require './components/ConnectionList.react'


request("http://localhost:3000/users").then((contents)->
  console.log contents

  # React.renderComponent(
  #   <App />,
  #   document.getElementById('react')
  # );

).catch(clientError, (e)->
  console.log 'Error', e
)

