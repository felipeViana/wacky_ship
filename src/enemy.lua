local MAX_SPAWN_DISTANCE = 800

local ENEMY_WIDTH = 50
local ENEMY_HEIGHT = 50

local colors = require 'src/colors'
local lume = require 'libs/lume'
local constants = require 'src/constants'
local enemyRed = require 'src/enemyRed'
local enemyGreen = require 'src/enemyGreen'

local enemy = {
  id,
  x,
  y,
}
enemy.meta = {
  __index = enemy,
}

function enemy.new(type)
  local newEnemy = {
    id = lume.uuid(),
    x = lume.random(constants.screenMinX + ENEMY_WIDTH/2, constants.screenMaxX - ENEMY_WIDTH/2),
    y = lume.random(constants.screenMinY - ENEMY_HEIGHT/2, constants.screenMinY - ENEMY_HEIGHT/2 - MAX_SPAWN_DISTANCE),
    type = type,
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
    end
  end
end

local function updateForType(dt, type, y)
  if type == 'red' then
    return enemyRed.update(dt, y)
  elseif type == 'green' then
    return enemyGreen.update(dt, y)
  else
    error('invalid enemy type at update')
  end
end

function enemy:update(dt)
  self.y = updateForType(dt, self.type, self.y)

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
  else
    error('invalid type enemy type at draw')
  end
end


return enemy;
