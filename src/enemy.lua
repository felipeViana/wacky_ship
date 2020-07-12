local MAX_SPAWN_DISTANCE = 800

local ENEMY_WIDTH = 50
local ENEMY_HEIGHT = 50

local colors = require 'src/colors'
local lume = require 'libs/lume'
local constants = require 'src/constants'
local enemyRed = require 'src/enemyRed'
local enemyGreen = require 'src/enemyGreen'
local enemyPurple = require 'src/enemyPurple'
local enemyBlue = require 'src/enemyBlue'

local enemy = {
  id,
  x,
  y,
}
enemy.meta = {
  __index = enemy,
}

function enemy.new(type)
  local initialX = lume.random(constants.screenMinX + ENEMY_WIDTH/2, constants.screenMaxX - ENEMY_WIDTH/2)
  local initialY = lume.random(constants.screenMinY - ENEMY_HEIGHT/2, constants.screenMinY - ENEMY_HEIGHT/2 - MAX_SPAWN_DISTANCE)
  local score
  if type == 'red' or type == 'green' then
    score = 1
  else
    score = 2
  end

  local newEnemy = {
    id = lume.uuid(),
    x = initialX,
    y = initialY,
    type = type,
    direction = math.floor(lume.random(0, 2)),
    timeAlive = 0 + lume.random(0, 2),
    initialX = initialX,
    initialY = initialY,
    score = score,
  }
  setmetatable(newEnemy, enemy.meta)
  return newEnemy
end

function enemy:load()
end

local function destroyEnemy(self)
  for index, enemyInstance in pairs(enemies) do
    if enemyInstance.id == self.id then
      table.remove(enemies, index)
      globalScore = globalScore + self.score
    end
  end
end

local function updateForType(dt, self)
  if self.type == 'red' then
    return enemyRed.update(dt, self)
  elseif self.type == 'green' then
    return enemyGreen.update(dt, self)
  elseif self.type == 'purple' then
    return enemyPurple.update(dt, self)
  elseif self.type == 'blue' then
    return enemyBlue.update(dt, self)
  else
    error('invalid enemy type at update')
  end
end

function enemy:update(dt)
  local position = updateForType(dt, self)
  self.x = position.x
  self.y = position.y

  if self.y > constants.screenMaxY + 100 then
    destroyEnemy(self)
  end
end

function enemy:draw()
  if self.type == 'green' then
    enemyGreen.draw(
      self.x,
      self.y,
      ENEMY_WIDTH,
      ENEMY_HEIGHT
    )
  elseif self.type == 'red' then
    enemyRed.draw(
      self.x,
      self.y,
      ENEMY_WIDTH,
      ENEMY_HEIGHT
    )
  elseif self.type == 'purple' then
    enemyPurple.draw(
      self.x,
      self.y,
      ENEMY_WIDTH,
      ENEMY_HEIGHT,
      self
    )
  elseif self.type == 'blue' then
    enemyBlue.draw(
      self.x,
      self.y,
      ENEMY_WIDTH,
      ENEMY_HEIGHT
    )
  else
    error('invalid type enemy type at draw')
  end
end


return enemy;
