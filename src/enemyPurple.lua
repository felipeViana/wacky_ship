local VERTICAL_SPEED = 150
local HORIZONTAL_SPEED = 100

local colors = require 'src/colors'

local enemy = {}

function enemy.update(dt, self)
  local newX
  local newY

  if self.direction == 0 then
    newY = self.initialY + VERTICAL_SPEED * self.timeAlive + HORIZONTAL_SPEED * math.sin(self.timeAlive * 2)
    newX = self.initialX + HORIZONTAL_SPEED * math.cos(self.timeAlive * 2)
  elseif self.direction == 1 then
    newY = self.initialY + VERTICAL_SPEED * self.timeAlive - HORIZONTAL_SPEED * math.cos(self.timeAlive * 2)
    newX = self.initialX + HORIZONTAL_SPEED * math.sin(self.timeAlive * 2)
  else
    error('invalid direction')
  end

  self.timeAlive = self.timeAlive + dt

  return {
    x = newX,
    y = newY,
  }
end

function enemy.draw(x, y, width, height, self)
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
