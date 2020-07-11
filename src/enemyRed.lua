local VERTICAL_SPEED = 200
local HORIZONTAL_SPEED = 200

local colors = require 'src/colors'

local enemy = {}

function enemy.update(dt, self)
  local newY = self.y + VERTICAL_SPEED * dt

  local newX = self.initialX + HORIZONTAL_SPEED * math.cos(self.timeAlive * 2)


  self.timeAlive = self.timeAlive + dt
  -- if self.direction == 0 and self.x > 550 then
  --   self.direction = 1
  -- elseif self.direction == 1 and self.x < 50 then
  --   self.direction = 0
  -- end

  -- if self.direction == 0 then
  --   newX = self.x + HORIZONTAL_SPEED * dt
  -- elseif self.direction == 1 then
  --   newX = self.x - HORIZONTAL_SPEED * dt
  -- else
  --   error('invalid direction')
  -- end

  return {
    x = newX,
    y = newY,
  }
end

function enemy.draw(x, y, width, height)
  love.graphics.setColor(colors.red)
  love.graphics.rectangle(
    'fill',
    x - width/2,
    y - height/2,
    width,
    height
  )
end


return enemy;
