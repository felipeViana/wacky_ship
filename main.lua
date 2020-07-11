local player = (require 'src/player').new()
local colors = require 'src/colors'

function love.load()
  player:load()
end

function love.update(dt)
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

  player:draw()
end

function love.keypressed(key)
  player:keypressed(key)
  if key == 'escape' then
    love.event.quit(0)
  end
end
