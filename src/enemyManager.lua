local colors = require 'src/colors'
local lume = require 'libs/lume'
local enemyCreator = require 'src/enemy'

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

function enemyManager:newEnemy(enemyType)
  local newEnemy
  if enemyType == 'red' then
    newEnemy = enemyCreator.new('red')
  elseif enemyType == 'green' then
    newEnemy = enemyCreator.new('green')
  else
    print(enemyType)
    error('invalid enemy type')
  end
  addNewEnemyToTable(self, newEnemy)
  return newEnemy
end

function enemyManager:load()
end

local function createEnemies()
  local quantity = lume.random(5, 10)

  for i = 0, quantity do
    local enemyType = math.floor(lume.random(0, 2))
    if enemyType == 0 then
      enemyManager:newEnemy('red')
    elseif enemyType == 1 then
      enemyManager:newEnemy('green')
    else
      print(enemyType)
      error('invalid enemy type')
    end
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
