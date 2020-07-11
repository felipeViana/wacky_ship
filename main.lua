local player = (require 'src/player').new()

function love.load()
  player:load()
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
  player:draw()
end

function love.keypressed(key)
  player:keypressed(key)
  if key == 'escape' then
    love.event.quit(0)
  end
end
