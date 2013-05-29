# Description: 
#   Generates help commands for Hubot.
#
# Commands:
#   hubot help - Displays all of the help commands that Hubot knows about.
#   hubot help <query> - Displays all help commands that match <query>.
#
# URLS:
#   /hubot/help
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.
module.exports = (robot) ->
  robot.respond /help\s*(.*)?$/i, (msg) ->
    msg.send 'Help can be found at the following link: http://terabot.heroku.com/help'

  robot.router.get '/help', (req, res) ->
    res.render 'help',
      title: "Help"
      commands: robot.helpCommands()
      robot: robot
