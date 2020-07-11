local colors = require 'src/colors'

local drawUtils = {}

function drawUtils.drawLifeBar(life)
  local originX = 650
  local originY = 200
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

local function drawBiggerTriangle(originX, originY, width, height)
  local positions = {
    originX + width/2,
    originY,

    originX + width,
    originY + height - 50,

    originX,
    originY + height - 50,
  }

  love.graphics.setColor(colors.black)
  love.graphics.polygon(
    'line',
    positions
  )
  love.graphics.setColor(colors.white)
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

local function drawThruster(originX, originY, state)
  local positions = {
    originX + 50,
    originY + 150,

    originX + 100,
    originY + 150,

    originX + 100 - 25/2,
    originY + 175,

    originX + 50 + 25/2,
    originY + 175,
  }
  drawPolygon(positions, state)
end

local function drawLeftWing(originX, originY, state)
  local positions = {
    originX,
    originY + 25,

    originX + 50,
    originY + 150,

    originX,
    originY + 150,
  }
  drawPolygon(positions, state)
end

local function drawRightWing(originX, originY, state)
  local positions = {
    originX + 150,
    originY + 25,

    originX + 150,
    originY + 150,

    originX + 100,
    originY + 150,
  }
  drawPolygon(positions, state)
end

local function drawLeftSmallWing(originX, originY, state)
  local positions = {
    originX + 40,
    -2*(originX + 40) + originY + 2*originX + 150,

    originX + 50,
    -2*(originX + 50) + originY + 2*originX + 150,

    originX + 30,
    originY + 20,
  }
  drawPolygon(positions, state)
end

local function drawRightSmallWing(originX, originY, state)
  local positions = {
    originX + 110,
    2*(originX + 110) + originY - 2*originX - 150,

    originX + 100,
    2*(originX + 100) + originY - 2*originX - 150,

    originX + 120,
    originY + 20,
  }
  drawPolygon(positions, state)
end

function drawUtils.drawShipDamageInfo(state)
  local originX = 625
  local originY = 500
  local width = 150
  local height = 200

  love.graphics.setColor(colors.darkgray)
  love.graphics.rectangle(
    'fill',
    originX,
    originY,
    width,
    height
  )
  love.graphics.setColor(colors.black)
  love.graphics.rectangle(
    'line',
    originX,
    originY,
    width,
    height
  )

  love.graphics.setNewFont(20)
  love.graphics.setColor(colors.white)
  love.graphics.print('Ship damage:', originX - 25, originY - 35)

  drawBiggerTriangle(originX, originY, width, height)
  drawThruster(originX, originY, state.up)
  drawLeftWing(originX, originY, state.left)
  drawRightWing(originX, originY, state.right)
  drawLeftSmallWing(originX, originY, state.down)
  drawRightSmallWing(originX, originY, state.down)

end

return drawUtils;
