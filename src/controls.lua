local NORMAL_SPEED = 300;
local DAMAGED_SPEED = 100;

local controls = {}

local function normalMovement(state)
  local velocityY = 0
  if love.keyboard.isDown('w', 'up') then
    if state.up == 'normal' then
      velocityY = velocityY - NORMAL_SPEED
    elseif state.up == 'damaged' then
      velocityY = velocityY - DAMAGED_SPEED
    else
      error('wrong state')
    end
  end
  if love.keyboard.isDown('s', 'down') then
    if state.down == 'normal' then
      velocityY = velocityY + NORMAL_SPEED
    elseif state.down == 'damaged' then
      velocityY = velocityY + DAMAGED_SPEED
    else
      error('wrong state')
    end
  end

  local velocityX = 0
  if love.keyboard.isDown('d', 'right') then
    if state.right == 'normal' then
      velocityX = velocityX + NORMAL_SPEED
    elseif state.right == 'damaged' then
      velocityX = velocityX + DAMAGED_SPEED
    else
      error('wrong state')
    end
  end
  if love.keyboard.isDown('a', 'left') then
    if state.left == 'normal' then
      velocityX = velocityX - NORMAL_SPEED
    elseif state.left == 'damaged' then
      velocityX = velocityX - DAMAGED_SPEED
    else
      error('wrong state')
    end
  end

  return {
    velocityX = velocityX,
    velocityY = velocityY,
  }
end


function controls.calculateVelocity(state)
  return normalMovement(state);
end

return controls;
