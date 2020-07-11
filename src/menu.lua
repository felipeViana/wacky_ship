local colors = require 'src/colors'

local menu = {}

function menu.draw()
  love.graphics.setColor(colors.white)
  love.graphics.setNewFont(20)
  love.graphics.print('Wacky Ship', 250, 75)

  love.graphics.print("You're navigating your spaceship battling against waves of enemies", 50, 200)
  love.graphics.print('you gradually lose control of your ship whenever it gets damaged.', 50, 250)

  love.graphics.print('press any key to start the game', 200, 400)

  love.graphics.print('Controls:', 100, 600)
  love.graphics.print('WASD or arrow keys to move', 100, 650)
  love.graphics.print('ESC to quit', 100, 700)
end


return menu
