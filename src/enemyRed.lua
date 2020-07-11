local ENEMY_WIDTH = 50
local ENEMY_HEIGHT = 50

local VERTICAL_SPEED = 200
local HORIZONTAL_SPEED = 20

local colors = require 'src/colors'
local lume = require 'libs/lume'
local constants = require 'src/constants'

local enemy = {
  id,
  x,
  y,
}
enemy.meta = {
  __index = enemy,
}

function enemy.new()
  local newEnemy = {
    id = lume.uuid(),
    x = lume.random(constants.screenMinX + ENEMY_WIDTH/2, constants.screenMaxX - ENEMY_WIDTH/2),
    y = lume.random(constants.screenMinY - ENEMY_HEIGHT/2, constants.screenMinY - ENEMY_HEIGHT/2 - 300),
  }
  setmetatable(newEnemy, enemy.meta)
  return newEnemy
end

function enemy:load()
end

local function destroyEnemy(self)
  for index, enemy in pairs(enemies) do
    if enemy.id == self.id then
      table.remove(enemies, index)
    end
  end
end

function enemy:update(dt)
  self.y = self.y + VERTICAL_SPEED * dt

  if self.y > constants.screenMaxY + 100 then
    destroyEnemy(self)
  end
end

function enemy:draw()
  love.graphics.setColor(colors.red)
  love.graphics.rectangle(
    'fill',
    self.x - ENEMY_WIDTH/2,
    self.y - ENEMY_HEIGHT/2,
    ENEMY_WIDTH,
    ENEMY_HEIGHT
  )
end


return enemy;
