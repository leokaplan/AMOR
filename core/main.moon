--love binding----    
global = require "global"
love.draw = -> global.trigger("draw")
love.update = (dt) -> global.trigger("update",dt)
love.keypressed = (key,scancode,isrepeat) -> global.trigger("keypressed",key,scancode,isrepeat)
love.keyreleased = (key,scancode,isrepeat) -> global.trigger("keyreleased",key,scancode,isrepeat)
------------------

ball = require "ball"
love.load = ->
    math.randomseed os.time!
    global.trigger("load")
    global.spawn (ball global)
