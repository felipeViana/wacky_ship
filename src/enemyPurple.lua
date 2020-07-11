local VERTICAL_SPEED = 300
local HORIZONTAL_SPEED = 20

local colors = require 'src/colors'

local enemy = {}

function enemy.update(dt, y)
  return y + VERTICAL_SPEED * dt
end

function enemy.draw(x, y, width, height)
  love.graphics.setColor(colors.indigo)
  love.graphics.rectangle(
    'fill',
    x - width/2,
    y - height/2,
    width,
    height
  )
end


return enemy;
