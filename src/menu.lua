local colors = require 'src/colors'

local menu = {}

local function drawRainbowCosText(text, time)
  for i=1, #text do
    for j=1, #colors.getRainbowColors() do
      local t1 = time + i*4 - j*2
      local y = 60 + math.cos(t1*3)*20

      love.graphics.setColor(colors.getRainbowColors()[j])
      love.graphics.print(text:sub(i, i), 200 + i * 30, y)
    end
  end
end

function menu.draw(timePassed)
  love.graphics.setColor(colors.white)
  love.graphics.setNewFont(20)
  drawRainbowCosText('WACKY SHIP', timePassed)

  love.graphics.print("You're navigating your spaceship battling against waves of enemies", 50, 200)
  love.graphics.print('you gradually lose control of your ship whenever it gets damaged.', 50, 250)

  love.graphics.print('press any key to start the game', 200, 400)

  love.graphics.print('Controls:', 100, 600)
  love.graphics.print('WASD or arrow keys to move', 100, 650)
  love.graphics.print('ESC to quit', 100, 700)
end


return menu
