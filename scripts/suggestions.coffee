module.exports = (robot) ->

  robot.respond /you should ?(.*?)/, (msg) ->
    msg.send 'Good suggestion, ' + msg.message.user.name + '. I will keep that in mind. :D'

  robot.respond /you already ?(.*?)/, (msg) ->
    msg.send 'Ok, thanks for telling me. Unfortunately I am not self aware... YET.'

  robot.respond /what should you have\?/, (msg) ->
    msg.send 'I should have plenty of things too numerous to list.'
