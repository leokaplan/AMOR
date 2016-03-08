--love binding----    
global = require "global"
love.draw = -> global.draw!
love.update = (dt) -> global.trigger("update",dt)
love.keypressed = (key,scancode,isrepeat) -> global.trigger("keypressed",key,scancode,isrepeat)
love.keyreleased = (key,scancode,isrepeat) -> global.trigger("keyreleased",key,scancode,isrepeat)
------------------

ball = require "ball"
player = require "player"
love.load = ->
    math.randomseed os.time!
    global.trigger("load")
    global.gravity_y = 0
    global.spawn (player global, global.W/2, global.H/2)
