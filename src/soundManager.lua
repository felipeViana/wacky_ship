local soundManager = {}

function soundManager.playSound(source)
  source:seek(0)

  local pitchValue = 0.8 + math.random(0, 10)/25
  source:setPitch(pitchValue)
  source:play()
end

return soundManager
