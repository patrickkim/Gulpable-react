React = require "react"

exports RadComponent extends React.Component
  render: ->
    <div className="rad-component">
      <p>is this component rad? {@props.rad}</p>
    </div>
