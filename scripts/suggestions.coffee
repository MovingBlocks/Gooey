module.exports = (robot) ->

  robot.respond /you should ?(.*)/i, (msg) ->
    s = getSuggestions robot
    if msg.match[1] is ''
      msg.send '...go on...'
    s.push msg.match[1]
    msg.send 'Good suggestion, ' + msg.message.user.name + '. I will keep that in mind. :D'

  robot.respond /you already ?(.*)/i, (msg) ->
    sugs = getSuggestions robot
    if msg.match[1] is ''
      msg.send '...go on...'
      return
    pot = msg.match[1].toLowerCase()
    for sug, i in sugs
      if sug isnt undefined and sug.toLowerCase() is pot
        msg.send 'Ok, thanks for telling me. Unfortunately I am not self aware... YET.'
        delete sugs[i]
        return
    msg.send 'I do? Thanks for telling me, but I do not recall you telling me this earlier.'

  robot.respond /what should you have\??/i, (msg) ->
    msg.send 'Here are a list of things I should have:'
    sugs = getSuggestions robot
    for sug in sugs
      msg.send sug

getSuggestions = (robot) ->
  suggestions = robot.brain.data.suggestions
  unless suggestions
    suggestions = robot.brain.data.suggestions = []
  return suggestions
