local VERTICAL_SPEED = 150
local HORIZONTAL_SPEED = 150

local colors = require 'src/colors'

local enemy = {}

function enemy.update(dt, self)
  local newY = self.y + VERTICAL_SPEED * dt
  local newX = self.initialX + HORIZONTAL_SPEED * math.cos(self.timeAlive * 2)
  self.timeAlive = self.timeAlive + dt

  return {
    x = newX,
    y = newY,
  }
end

function enemy.draw(x, y, width, height)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(redShipImage, x - width/2, y - height/2)
end


return enemy;
