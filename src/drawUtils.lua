local colors = require 'src/colors'

local drawUtils = {}

function drawUtils.drawLifeBar(life)
  local originX = 650
  local originY = 275
  local width = 50
  local heightTotal = 200 -- piece * 4
  local heightPiece = 50
  local roundRadius = 5

  love.graphics.setNewFont(20)
  love.graphics.setColor(colors.white)
  love.graphics.print('Life:', originX - 25, originY - 35)

  love.graphics.setColor(colors.black)
  love.graphics.rectangle(
    'line',
    originX,
    originY,
    width,
    heightTotal,
    roundRadius,
    roundRadius
  )

  love.graphics.setColor(colors.darkgray)
  love.graphics.rectangle(
    'fill',
    originX,
    originY,
    width,
    heightTotal,
    roundRadius,
    roundRadius
  )

  love.graphics.setColor(colors.red)
  if life > 0 then
    love.graphics.rectangle(
      'fill',
      originX,
      originY + heightTotal - life * heightPiece,
      width,
      life * heightPiece,
      roundRadius,
      roundRadius
    )
  end
end

local function drawBiggerTriangle(originX, originY, width, height, life)
  local positions = {
    originX + width/2,
    originY,

    originX + width,
    originY + height * 3/4,

    originX,
    originY + height * 3/4,
  }

  love.graphics.setColor(colors.black)
  love.graphics.polygon(
    'line',
    positions
  )
  love.graphics.setColor(colors.white)
  if life < 0 then
    love.graphics.setColor(colors.red)
  end
  love.graphics.polygon(
    'fill',
    positions
  )
end

local function drawPolygon(positions, state)
  love.graphics.setColor(colors.black)
  love.graphics.polygon(
    'line',
    positions
  )
  love.graphics.setColor(colors.white)
  if state == 'damaged' then
    love.graphics.setColor(colors.red)
  end
  love.graphics.polygon(
    'fill',
    positions
  )
end

local function drawThruster(originX, originY, width, height, state)
  local positions = {
    originX + width/3,
    originY + height*3/4,

    originX + width*2/3,
    originY + height*3/4,

    originX + width*2/3 - width/12,
    originY + height*3/4 + height/12,

    originX + width/3 + width/12,
    originY + height*3/4 + height/12,
  }
  drawPolygon(positions, state)
end

local function drawLeftWing(originX, originY, width, height, state)
  local positions = {
    originX,
    originY + height/8,

    originX + width/3,
    originY + height * 3/4,

    originX,
    originY + height * 3/4,
  }
  drawPolygon(positions, state)
end

local function drawRightWing(originX, originY, width, height, state)
  local positions = {
    originX + width,
    originY + height/8,

    originX + width,
    originY + height * 3/4,

    originX + width*2/3,
    originY + height * 3/4,
  }
  drawPolygon(positions, state)
end

local function drawLeftSmallWing(originX, originY, width, height, state)
  local positions = {
    originX + 40/150 * width,
    - 3/2*height/width*(originX + 40/150 * width) + originY + 3/2 * height/width * originX + 3/4 * height,

    originX + 50/150 * width,
    - 3/2*height/width*(originX + 50/150 * width) + originY + 3/2 * height/width * originX + 3/4 * height,

    originX + width/5,
    originY + height/10,
  }
  drawPolygon(positions, state)
end

local function drawRightSmallWing(originX, originY, width, height, state)
  local positions = {
    originX + 110/150 * width,
    -- 2*(originX + 110) + originY - 2*originX - 150,
    3/2*height/width*(originX + 110/150 * width) + originY - 3/2 * height/width * originX - 3/4 * height,

    originX + 100/150 * width,
    -- 2*(originX + 100) + originY - 2*originX - 150,
    3/2*height/width*(originX + 100/150 * width) + originY - 3/2 * height/width * originX - 3/4 * height,

    originX + width * 4/5,
    originY + height/10,
  }
  drawPolygon(positions, state)
end

function drawUtils.drawShipDamageInfo(self)
  local originX = 625
  local originY = 550
  local width = 150
  local height = 200

  love.graphics.setNewFont(20)
  love.graphics.setColor(colors.white)
  love.graphics.print('Ship damage:', originX - 20, originY - 35)

  drawBiggerTriangle(originX, originY, width, height, self.life)
  drawThruster(originX, originY, width, height, self.state.up)
  drawLeftWing(originX, originY, width, height, self.state.left)
  drawRightWing(originX, originY, width, height, self.state.right)
  drawLeftSmallWing(originX, originY, width, height, self.state.down)
  drawRightSmallWing(originX, originY, width, height, self.state.down)
end

function drawUtils.drawPlayer(self, width, height)
  local originX = self.x - width/2
  local originY = self.y - height/2

  drawBiggerTriangle(originX, originY, width, height, self.life)
  drawThruster(originX, originY, width, height, self.state.up)
  drawLeftWing(originX, originY, width, height, self.state.left)
  drawRightWing(originX, originY, width, height, self.state.right)
  drawLeftSmallWing(originX, originY, width, height, self.state.down)
  drawRightSmallWing(originX, originY, width, height, self.state.down)
end

return drawUtils;
