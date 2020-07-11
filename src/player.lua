local lume = require 'libs/lume'
local colors = require 'src/colors'
local controls = require 'src/controls'
local collisions = require 'src/collisions'

local PLAYER_WIDTH = 50;
local PLAYER_HEIGHT = 50;
local SPEED = 200;

local player = {
  x,
  y,
  velocityX,
  velocityY,
  state,
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
    state = {
      up = 'normal',
      left = 'normal',
      right = 'normal',
      down = 'normal',
    },
  }
  setmetatable(newPlayer, player.meta)
  return newPlayer
end

function player:load()
end

function player:unload()
end

function player:update(dt)
   local velocity = controls.calculateVelocity(self.state)
   self.velocityX = velocity.velocityX
   self.velocityY = velocity.velocityY

  self.x = self.x + self.velocityX * dt
  self.y = self.y + self.velocityY * dt

  local finalPosition = collisions.fitInScreen(self.x, self.y, PLAYER_WIDTH, PLAYER_HEIGHT)
  self.x = finalPosition.x
  self.y = finalPosition.y
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
