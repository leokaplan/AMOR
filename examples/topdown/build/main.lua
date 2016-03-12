local global = require("core/global")
love.draw = function()
  return global.draw()
end
love.update = function(dt)
  return global.trigger("update", dt)
end
love.keypressed = function(key, scancode, isrepeat)
  return global.trigger("keypressed", key, scancode, isrepeat)
end
love.keyreleased = function(key, scancode, isrepeat)
  return global.trigger("keyreleased", key, scancode, isrepeat)
end
local ball = require("ball")
local player = require("player")
love.load = function()
  math.randomseed(os.time())
  global.trigger("load")
  global.gravity_y = 0
  return global.spawn((player(global, global.W / 2, global.H / 2)))
end
