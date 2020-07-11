local VERTICAL_SPEED = 300
local HORIZONTAL_SPEED = 200

local colors = require 'src/colors'

local enemy = {}

function enemy.update(dt, self)
  local newY = self.y + VERTICAL_SPEED * dt
  local newX = self.x

  return {
    x = newX,
    y = newY,
  }
end

function enemy.draw(x, y, width, height)
  love.graphics.setColor(colors.blue)
  love.graphics.rectangle(
    'fill',
    x - width/2,
    y - height/2,
    width,
    height
  )
end


return enemy;
