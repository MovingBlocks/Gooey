# Description:
#   Logs chat messages to a MongoDB instance
#
# Dependencies:
#   mongoose
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   AlbireoX

module.exports = (robot) ->
  mongoose = require 'mongoose'
  mongoose.connect process.env.MONGOHQ_URL

  Message = mongoose.model('Message',
    user: String
    message: String
    target: String
    date: Date
  )

  robot.adapter.bot.on 'message', (nick, to, text, message) ->
    msg = new Message name: nick, message: message, target: to, date: new Date()
    msg.save (err) ->
      console.log err if err
      console.log "#{to} #{nick}: #{message}"

