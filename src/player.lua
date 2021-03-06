local lume = require 'libs/lume'
local colors = require 'src/colors'
local controls = require 'src/controls'
local collisions = require 'src/collisions'
local drawUtils = require 'src/drawUtils'
local soundManager = require 'src/soundManager'

local PLAYER_WIDTH = 50;
local PLAYER_HEIGHT = 200/3;
local SPEED = 200;
local isColliding = false
local INVICIBILITY_TIME = 1

local shootSpeed = 300
shootX=0
shootY=0

local player = {
  x,
  y,
  velocityX,
  velocityY,
  state,
  shooting,
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
      right = 'normal',
      down = 'normal',
      left = 'normal',
    },
    life = 4,
    invicibilityLeft = 0,
    shooting = false,
  }
  setmetatable(newPlayer, player.meta)
  return newPlayer
end

function player:load()
end

function player:reset()
  self.x = 300
  self.y = 600
  self.life = 4
  self.invicibilityLeft = 0
  self.shooting = false

  self.state = {
    up = 'normal',
    right = 'normal',
    down = 'normal',
    left = 'normal',
  }
end

function player:unload()
end

local function damageShip(self)
  if self.life == 4 then
    self.state.right = 'damaged'
  elseif self.life == 3 then
    self.state.down = 'damaged'
  elseif self.life == 2 then
    self.state.left = 'damaged'
  elseif self.life == 1 then
    self.state.up = 'damaged'
  end
end

local function getHit(self)
  damageShip(self)
  self.life = self.life - 1
  self.invicibilityLeft = INVICIBILITY_TIME

  if self.life < 0 then
    -- love.event.quit(0)
    soundManager.playSound(shipExplosionSound)
    globalGameState = 'gameOver'
    music:stop()
  else
    soundManager.playSound(shipDamageSound)
  end
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

  shootY = shootY - shootSpeed * dt
  isShootColliding = collisions.checkForShoot()
  if isShootColliding or shootY < 0 then
    shootY = 0
    shootX = 0

    self.shooting = false
  end

  isColliding = collisions.checkForCollisions(self.x, self.y)
  if isColliding and self.invicibilityLeft <= 0 then
    getHit(self)
  end

  if self.invicibilityLeft > -1 then
    self.invicibilityLeft = self.invicibilityLeft - dt
  end

  globalPlayerX = self.x
  globalPlayerY = self.y
end

function player:draw()
  if DEBUG then
    love.graphics.setNewFont(12)
    love.graphics.setColor(colors.white)
    if isColliding then
      love.graphics.print('is colliding', 0, 20)
    end

    love.graphics.print('invicibilityLeft = ' .. self.invicibilityLeft, 0, 40)
  end

  love.graphics.setColor(colors.white)
  love.graphics.circle(
    'fill',
    shootX,
    shootY,
    5
  )

  drawUtils.drawLifeBar(self.life)

  drawUtils.drawShipDamageInfo(self)

  drawUtils.drawPlayer(self, PLAYER_WIDTH, PLAYER_HEIGHT)
end

local function createShoot(self)
  shootY=self.y-30
  shootX=self.x

  self.shooting = true
end

function player:keypressed(key)
  if key == 'space' then
    if not self.shooting then
      createShoot(self)
    end
  end
end

return player;
