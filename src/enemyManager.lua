local colors = require 'src/colors'
local lume = require 'libs/lume'
local enemyCreator = require 'src/enemy'

globalWave = 0

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
  elseif enemyType == 'purple' then
    newEnemy = enemyCreator.new('purple')
  elseif enemyType == 'blue' then
    newEnemy = enemyCreator.new('blue')
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
  local enemyTypesInitial = {
    'red', 'green'
  }
  local allEnemyTypes = {
    'red', 'green', 'purple'
  }

  local enemyTypes
  if globalWave < 3 then
    enemyTypes = enemyTypesInitial
  else
    enemyTypes = allEnemyTypes
  end

  local minEnemies
  local maxEnemies
  if globalWave < 2 then
    minEnemies = 3
    maxEnemies = 6
  elseif globalWave < 4 then
    minEnemies = 6
    maxEnemies = 10
  elseif globalWave < 6 then
    minEnemies = 10
    maxEnemies = 14
  elseif globalWave < 8 then
    minEnemies = 14
    maxEnemies = 18
  elseif globalWave < 10 then
    minEnemies = 18
    maxEnemies = 26
  elseif globalWave < 12 then
    minEnemies = 26
    maxEnemies = 34
  elseif globalWave < 14 then
    minEnemies = 34
    maxEnemies = 45
  elseif globalWave < 16 then
    minEnemies = 45
    maxEnemies = 65
  else
    minEnemies = 65
    maxEnemies = 100
  end

  local quantity = lume.random(minEnemies, maxEnemies)

  for i = 0, quantity do
    local enemyType = math.floor(lume.random(1, #enemyTypes+1))
    enemyManager:newEnemy(enemyTypes[enemyType])
  end

  globalWave = globalWave + 1
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

  if DEBUG then
    love.graphics.setNewFont(12)
    love.graphics.print(lume.serialize(enemies))
    love.graphics.print('#enemies = ' .. #enemies, 0, 10)
  end

  for _, enemy in pairs(enemies) do
    enemy:draw()
  end
end


return enemyManager;
