local player = (require 'src/player').new()
local enemyManager = (require 'src/enemyManager').new()
local colors = require 'src/colors'

DEBUG = false
enemies = {}
globalPlayerX = 0
globalPlayerY = 0
globalScore = 0
globalHighScore = 0
globalGameState = 'inGame' -- [inGame, paused, menu, gameOver]

function love.load()
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
end

function love.draw()

  if globalGameState == 'inGame' or globalGameState == 'gameOver' then
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
end

local function restartTheGame()
  globalGameState = 'inGame'
  enemies = {}
  globalPlayerX = 0
  globalPlayerY = 0
  globalScore = 0

  player:reset()
end

function love.keypressed(key)
  if globalGameState == 'inGame' then
    player:keypressed(key)
  end

  if globalGameState == 'gameOver' and key == 'r' then
    print('restarting the game')
    restartTheGame()
  end

  if key == 'escape' then
    love.event.quit(0)
  end
end
