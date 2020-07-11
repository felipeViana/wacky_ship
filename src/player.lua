local lume = require 'libs/lume'
local colors = require 'src/colors'

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
    x = 300,
    y = 600,
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

  -- screen boundaries
  if self.x + PLAYER_WIDTH/2 > 600 then
    self.x = 600 - PLAYER_WIDTH/2
  end

  if self.x - PLAYER_WIDTH/2 < 0 then
    self.x = 0 + PLAYER_WIDTH/2
  end

  if self.y - PLAYER_HEIGHT/2 < 0 then
    self.y = 0 + PLAYER_HEIGHT/2
  end

  if self.y + PLAYER_HEIGHT/2 > 800 then
    self.y = 800 - PLAYER_HEIGHT/2
  end
end

function player:draw()
  love.graphics.setColor(colors.white)
  love.graphics.rectangle(
    'fill',
    self.x - PLAYER_WIDTH/2,
    self.y - PLAYER_HEIGHT/2,
    PLAYER_WIDTH,
    PLAYER_HEIGHT
  )
end

function player:keypressed(key)
end

return player;
