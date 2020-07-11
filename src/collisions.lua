local maxX = 600
local maxY = 800

local collisions = {}

function collisions.fitInScreen(x, y, width, height)
  local compX = x;
  local compY = y;

  if x + width/2 > maxX then
    compX = maxX - width/2
  end

  if x - width/2 < 0 then
    compX = 0 + width/2
  end

  if y - height/2 < 0 then
    compY = 0 + height/2
  end

  if y + height/2 > maxY then
    compY = maxY - height/2
  end

  return {
    x = compX,
    y = compY,
  }
end

return collisions;
