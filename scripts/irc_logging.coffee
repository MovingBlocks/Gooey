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
    nick: String
    message: String
    target: String
    date: Date
  )

  robot.adapter.bot.on 'message', (nick, to, text, message) ->
    msg = new Message nick: nick, message: text, target: to, date: new Date()
    msg.save (err) ->
      console.log err if err
      console.log "#{to} #{nick}: #{text}"

  robot.router.get '/logs', (req, res) ->
    Message.find(target: '#terasology').limit(100).exec (err, messages) ->
      res.render 'logs',
        title: 'Logs'
        messages: messages

