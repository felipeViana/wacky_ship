local player = (require 'src/player').new()
local enemyManager = (require 'src/enemyManager').new()
local colors = require 'src/colors'
local menu = require 'src/menu'

DEBUG = false
enemies = {}
globalPlayerX = 0
globalPlayerY = 0
globalScore = 0
globalHighScore = 0
globalGameState = 'menu' -- [inGame, paused, menu, gameOver]

local timePassed = 0

function love.load()
  shipDamageSound = love.audio.newSource("assets/shipDamage.wav", "static")
  shipExplosionSound = love.audio.newSource("assets/shipExplosion.wav", "static")

  music = love.audio.newSource("assets/mainTheme.wav", "stream")
  music:setLooping(true)

  greenShipImage = love.graphics.newImage("assets/greenShip.png")
  redShipImage = love.graphics.newImage("assets/redShip.png")

  enemyManager:load()
  player:load()
end

function love.update(dt)
  if globalGameState == 'inGame' then

    enemyManager:update(dt)
    player:update(dt)

    if globalScore > globalHighScore then
      globalHighScore = globalScore
    end
  end

  timePassed = timePassed + dt
end

function love.draw()
  if DEBUG then
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 0, 100)
  end

  if globalGameState == 'menu' then
    menu.draw(timePassed)
  end

  if globalGameState == 'inGame' or globalGameState == 'gameOver' or globalGameState == 'paused' then
    enemyManager:draw()

    love.graphics.setColor(colors.indigo)
    love.graphics.rectangle(
      'fill',
      600,
      0,
      200,
      800
    )
    player:draw()

    love.graphics.setColor(colors.white)
    love.graphics.setNewFont(20)

    love.graphics.print('wave ' .. globalWave, 650, 25)
    love.graphics.print('score: ' .. globalScore, 605, 75)
    love.graphics.print('high score: ' .. globalHighScore, 605, 125)
  end

  if globalGameState == 'gameOver' then
    love.graphics.print('GAME OVER', 250, 300)
    love.graphics.print('press R to restart the game', 200, 400)
  end

  if globalGameState == 'paused' then
    love.graphics.print('PAUSED', 250, 175)
    love.graphics.print('press P or ESC to unpause', 200, 225)
  end
end

local function restartTheGame()
  globalGameState = 'inGame'
  enemies = {}
  globalPlayerX = 0
  globalPlayerY = 0
  globalScore = 0
  globalWave = 0

  player:reset()
  music:play()
end

function love.keypressed(key)
  if globalGameState == 'menu' and key == 'return' then
    globalGameState = 'inGame'
    music:play()
  end

  if globalGameState == 'inGame' then
    player:keypressed(key)
  end

  if globalGameState == 'gameOver' and key == 'r' then
    print('restarting the game')
    restartTheGame()
  end

  if key == 'p' or key == 'escape' then
    if globalGameState == 'inGame' then
      globalGameState = 'paused'
    elseif globalGameState == 'paused' then
      globalGameState = 'inGame'
    end
  end

  if DEBUG and key == 'escape' then
    love.event.quit(0)
  end
end

function love.focus(f)
  if not f and globalGameState == 'inGame' then
    globalGameState = 'paused'
  end
end
