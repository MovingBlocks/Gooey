# Description:
#   Allows interaction with github
#
# Dependencies:
#   "githubot": "0.4.0"
#
# Configuration:
#   None - use githubot
#
# Commands:
#   hubot create repo <repo name> - Creates a repo in MovingBlocks with the given name
#
# Author:
#   simplyianm
module.exports = (robot) ->
  github = require('githubot') robot

  robot.respond /create repo (["'\w: -_]+)/i, (msg) ->
    unless robot.Auth.hasRole msg.message.user.name, 'github'
      msg.send "Why should I listen to you, #{msg.message.user.name}?"
      return

    data =
      name: msg.match[1].trim()

    github.post 'orgs/Terasology/repos', data, (repo) ->
      msg.send "Repo #{repo.name} created at #{url}"
