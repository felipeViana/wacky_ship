local player = (require 'src/player').new()
local enemyManager = (require 'src/enemyManager').new()
local colors = require 'src/colors'

DEBUG = false
enemies = {}
globalPlayerX = 0
globalPlayerY = 0

function love.load()
  enemyManager:load()
  player:load()
end

function love.update(dt)
  enemyManager:update(dt)
  player:update(dt)
end

function love.draw()
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
  love.graphics.print('wave ' .. globalWave, 650, 50)
end

function love.keypressed(key)
  player:keypressed(key)
  if key == 'escape' then
    love.event.quit(0)
  end
end
