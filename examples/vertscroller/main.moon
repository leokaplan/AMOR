--love binding----    
global = require "core/global"
love.draw = -> global.draw!
love.update = (dt) -> global.trigger("update",dt)
love.keypressed = (key,scancode,isrepeat) -> global.trigger("keypressed",key,scancode,isrepeat)
love.keyreleased = (key,scancode,isrepeat) -> global.trigger("keyreleased",key,scancode,isrepeat)
------------------
level = require "level"
love.load = ->
    math.randomseed os.time!
    --global.debug = true
    global.spawn level global
    global.trigger("load")
