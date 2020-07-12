local constants = require 'src/constants'

local collisions = {}

function collisions.fitInScreen(x, y, width, height)
  local compX = x;
  local compY = y;

  if x + width/2 > constants.screenMaxX then
    compX = constants.screenMaxX - width/2
  end

  if x - width/2 < constants.screenMinX then
    compX = constants.screenMinX + width/2
  end

  if y - height/2 < constants.screenMinY then
    compY = constants.screenMinY + height/2
  end

  if y + height/2 > constants.screenMaxY then
    compY = constants.screenMaxY - height/2
  end

  return {
    x = compX,
    y = compY,
  }
end

local function isCollidingWithEnemy(x1, y1, x2, y2)
  if math.abs(x1-x2) > 100 or math.abs(y1-y2) > 100 then
    return false
  end

  local d2 = (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)
  local r = 50
  return d2 <= r*r
end

function collisions.checkForCollisions(playerX, playerY)
  for _, enemy in pairs(enemies) do
    if isCollidingWithEnemy(enemy.x, enemy.y, playerX, playerY) then
      return true
    end
  end

  return false
end

return collisions;
