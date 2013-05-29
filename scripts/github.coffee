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
      msg.send "Repo #{repo.name} created at #{repo.html_url}"

  robot.respond /add (["'\w: -_]+) to team (["'\w: -_]+)/i, (msg) ->
    unless robot.Auth.hasRole msg.message.user.name, 'github'
      msg.send "Why should I listen to you, #{msg.message.user.name}?"
      return

    github.get 'orgs/Terasology/teams', (teams) ->
      ourTeam = null
      for team in teams
        if team.name.toLowerCase() is msg.match[2]
          ourTeam = team
          break

      if ourTeam is null
        msg.send "There is no team named '#{msg.match[2]}'!"
        return

      github.get "users/#{msg.match[1]}", (user) ->
        if user is null
          msg.send "There is no user on Github named '#{msg.match[1]}'!"
          return

        username = user.login
        github.request 'PUT', "teams/#{ourTeam.id}/members/#{username}", {}, (res) ->
          msg.send "#{username} has been added to the team #{ourTeam.name}."
