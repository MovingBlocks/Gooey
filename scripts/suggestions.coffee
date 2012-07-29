module.exports = (robot) ->

  robot.respond /you should ?(.*)/i, (msg) ->
    s = getSuggestions robot
    s.push msg.match[1]
    msg.send 'Good suggestion, ' + msg.message.user.name + '. I will keep that in mind. :D'

  robot.respond /you already ?(.*)/i, (msg) ->
    sugs = getSuggestions robot
    for sug, i in sugs
      if sug.toLowerCase() is msg.match[1]
        msg.send 'Ok, thanks for telling me. Unfortunately I am not self aware... YET.'
        delete sugs[i]
        return
    msg.send 'I do? Thanks for telling me, but I do not recall you telling me this earlier.'

  robot.respond /what should you have\??/i, (msg) ->
    msg.send 'I should have plenty of things too numerous to list.'

getSuggestions = (robot) ->
  suggestions = robot.brain.data.suggestions
  unless suggestions
    suggestions = robot.brain.data.suggestions = []
  return suggestions
