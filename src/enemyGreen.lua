local VERTICAL_SPEED = 400
local HORIZONTAL_SPEED = 20

local colors = require 'src/colors'

local enemy = {}

function enemy.update(dt, y)
  return y + VERTICAL_SPEED * dt
end

function enemy.draw(x, y, width, height)
  love.graphics.setColor(colors.green)
  love.graphics.polygon(
    'fill',
    x - width/2,
    y - height/2,

    x + width/2,
    y - height/2,

    x,
    y + height/2
  )
end


return enemy;
