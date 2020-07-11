local colors = require 'src/colors'
local lume = require 'libs/lume'
local enemyRed = require 'src/enemyRed'

local enemyManager = {
}
enemyManager.meta = {
  __index = enemyManager,
}

function enemyManager.new()
  local newEnemyManager = {}
  setmetatable(newEnemyManager, enemyManager.meta)
  return newEnemyManager
end

local function addNewEnemyToTable(self, newEnemy)
  table.insert(
    enemies,
    newEnemy
  )
end

function enemyManager:newEnemy(type)
  local newEnemy
  if type == 'red' then
    newEnemy = enemyRed.new()
  else
    error('invalid type')
  end
  addNewEnemyToTable(self, newEnemy)
  return newEnemy
end

function enemyManager:load()
end

local function createEnemies()
  local quantity = lume.random(5, 10)

  for i = 0, quantity do
    enemyManager:newEnemy('red')
  end
end

function enemyManager:update(dt)
  for _, enemy in pairs(enemies) do
    enemy:update(dt)
  end

  if #enemies == 0 then
    createEnemies()
  end
end

function enemyManager:draw()
  love.graphics.setColor(colors.white)
  love.graphics.print(lume.serialize(enemies))
  love.graphics.print('#enemies = ' .. #enemies, 0, 10)

  for _, enemy in pairs(enemies) do
    enemy:draw()
  end
end


return enemyManager;
