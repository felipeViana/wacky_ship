local VERTICAL_SPEED = 380
local HORIZONTAL_SPEED = 60

local colors = require 'src/colors'
local lume = require 'libs/lume'

local enemy = {}

function enemy.update(dt, self)
  local newY = self.y + VERTICAL_SPEED * dt
  local newX

  local willChangeDirection = lume.random() > 0.99

  if willChangeDirection then
    if self.direction == 1 then
      self.direction = 0
    elseif self.direction == 0 then
      self.direction = 1
    end
  end

  if self.direction == 0 then
    newX = self.x + HORIZONTAL_SPEED * dt
  elseif self.direction == 1 then
    newX = self.x - HORIZONTAL_SPEED * dt
  end

  return {
    x = newX,
    y = newY,
  }
end

function enemy.draw(x, y, width, height)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(greenShipImage, x - width/2, y - height/2, math.pi)

end


return enemy;
