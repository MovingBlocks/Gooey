# Description:
#   Tell Hubot to send a user a message when present in the room
#
# Dependencies:
#  "moment": "1.7.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot tell <username> <some message> - tell <username> <some message> next time they are present
#
# Author:
#   simplyianm aka AlbireoX
moment = require 'moment'

class MBTell
  constructor: (@robot) ->
    messages = @robot.brain.data.messages
    @robot.brain.data.messages = {} unless messages

  addMessage: (sender, receiver, msg) ->
    current = @robot.brain.data.messages[receiver]
    current = @robot.brain.data.messages[receiver] = [] unless current
    current.push sender: sender, msg: msg, date: (new Date()).getTime()

  resetMessages: (nick) ->
    delete @robot.brain.data.messages[nick]

  getMessages: (nick) ->
    @robot.brain.data.messages[nick]

module.exports = (robot) ->
  tell = new MBTell robot

  robot.respond /tell ([\w.-`]*) (.*)/i, (msg) ->
    tell.addMessage msg.message.user.name, msg.match[1].toLowerCase(), msg.match[2]
    msg.send "Yes sir, " + msg.message.user.name + "! I'll relay the message to " + msg.match[1] + " when they get back online."

  robot.hear /./i, (msg) ->
    # just send the messages if they are available...
    name = msg.message.user.name.toLowerCase()
    msgs = tell.getMessages name
    if msgs
      for m in msgs
        msg.send moment(new Date(m.date)).fromNow() + ', ' + m.sender + ' said: ' + m.msg
      tell.resetMessages name

  robot.enter (msg) ->
    user = msg.message.user.name.toLowerCase()
    if tell.getMessages user
      msg.send msg.message.user.name + ': You have messages waiting. Say something in this chat to receive your message.'
