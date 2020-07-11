local player = (require 'src/player').new()
local enemyManager = (require 'src/enemyManager').new()
local colors = require 'src/colors'

enemies = {}

function love.load()
  enemyManager:load()
  -- enemyManager:newEnemy('red')
  -- enemyManager:newEnemy('red')
  player:load()
end

function love.update(dt)
  enemyManager:update(dt)
  player:update(dt)
end

function love.draw()
  love.graphics.setColor(colors.violet)
  love.graphics.rectangle(
    'fill',
    600,
    0,
    200,
    800
  )

  enemyManager:draw()
  player:draw()
end

function love.keypressed(key)
  player:keypressed(key)
  if key == 'escape' then
    love.event.quit(0)
  end
end
