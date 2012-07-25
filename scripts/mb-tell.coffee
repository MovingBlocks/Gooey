# Description:
#   Tell Hubot to send a user a message when present in the room
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot tell <username> <some message> - tell <username> <some message> next time they are present
#
# Author:
#   simplyianm aka AlbireoX

module.exports = (robot) ->
  localstorage = {}
  robot.respond /tell ([\w.-]*) (.*)/i, (msg) ->
    datetime = new Date()
    name = msg.match[1].toLowerCase()
    tellmessage = name + ": " + msg.message.user.name + " @ " + datetime.toTimeString() + " said: " + msg.match[2] + "\r\n"
    if localstorage[name] == undefined
      localstorage[name] = tellmessage
    else
      localstorage[name] += tellmessage

    msg.send "Yes sir, " + msg.message.user.name + "! I'll relay the message to " + msg.match[1] + " when they get back online."

  robot.hear /./i, (msg) ->
    # just send the messages if they are available...
    name = msg.message.user.name.toLowerCase()
    if localstorage[name] != undefined
      tellmessage = localstorage[name]
      delete localstorage[name]
      msg.send tellmessage
    return

  robot.enter (msg) ->
    user = msg.message.user.name.toLowerCase()
    msg.send user + ': You have messages waiting. Say something in this chat to receive your message.' if localstorage[user]?
