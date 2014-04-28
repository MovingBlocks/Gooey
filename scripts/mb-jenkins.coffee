module.exports = (robot) ->
  robot.router.post 'hubot/jenkins-notify', (req, res) ->
    try
      data = req.body
      return if data.build.phase isnt 'FINISHED'
    
      robot.send {room: '#terasology'}, "#{data.name} build ##{data.build.number} ended in #{data.build.status} (#{data.build.full_url})"
    catch e
      console.log "MB-Jenkins error: #{e}. Data: #{req.body}"
      console.log e.stack
