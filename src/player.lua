local lume = require 'libs/lume'

local PLAYER_WIDTH = 50;
local PLAYER_HEIGHT = 50;
local SPEED = 200;

local player = {
  x,
  y,
  velocityX,
  velocityY,
}
player.meta = {
  __index = player,
}

function player.new()
  local newPlayer = {
    x = 100,
    y = 500,
    velocityX = 0,
    velocityY = 0,
  }
  setmetatable(newPlayer, player.meta)
  return newPlayer
end

function player:load()
end

function player:unload()
end

function player:update(dt)
  local velocityY = 0
  if love.keyboard.isDown('w', 'up') then
    velocityY = velocityY - SPEED
  end
  if love.keyboard.isDown('s', 'down') then
    velocityY = velocityY + SPEED
  end
  self.velocityY = velocityY

  local velocityX = 0
  if love.keyboard.isDown('d', 'right') then
    velocityX = velocityX + SPEED
  end
  if love.keyboard.isDown('a', 'left') then
    velocityX = velocityX - SPEED
  end
  self.velocityX = velocityX

  self.x = self.x + self.velocityX * dt
  self.y = self.y + self.velocityY * dt
end

function player:draw()
  love.graphics.rectangle(
    'fill',
    self.x,
    self.y,
    PLAYER_WIDTH,
    PLAYER_HEIGHT
  )
end

function player:keypressed(key)
end

return player;
