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

local function isShootCollidingWithEnemy(x1, y1, x2, y2)
  if math.abs(x1-x2) > 100 or math.abs(y1-y2) > 100 then
    return false
  end


  local d2 = (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)
  local r = 32
  return d2 <= r*r
end

local function killEnemy(enemyId)
  for index, enemyInstance in pairs(enemies) do
    if enemyInstance.id == enemyId then
      globalScore = globalScore + enemyInstance.score
      table.remove(enemies, index)
    end
  end
end

function collisions.checkForShoot()
  for _, enemy in pairs(enemies) do
    if isShootCollidingWithEnemy(enemy.x, enemy.y, shootX, shootY) then
      killEnemy(enemy.id)
      return true
    end
  end

  return false
end

return collisions;
