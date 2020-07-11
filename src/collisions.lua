local constants = require 'src/constants'

local collisions = {}

function collisions.fitInScreen(x, y, width, height)
  local compX = x;
  local compY = y;

  if x + width/2 > constants.screenMaxX then
    compX = constants.screenMaxX - width/2
  end

  if x - width/2 < constants.screenMinX then
    compX = constants.screenMinX + width/2
  end

  if y - height/2 < constants.screenMinY then
    compY = constants.screenMinY + height/2
  end

  if y + height/2 > constants.screenMaxY then
    compY = constants.screenMaxY - height/2
  end

  return {
    x = compX,
    y = compY,
  }
end

return collisions;
