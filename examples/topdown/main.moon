--love binding----    
global = require "core/global"
love.draw = -> global.draw!
love.update = (dt) -> 
    --print love.timer.getFPS!,#global.objs,#global.timers
    global.trigger("update",dt)
love.keypressed = (key,scancode,isrepeat) -> global.trigger("keypressed",key,scancode,isrepeat)
love.keyreleased = (key,scancode,isrepeat) -> global.trigger("keyreleased",key,scancode,isrepeat)
------------------

map = require "map"
player = require "player"
enemy = require "enemy"
love.load = ->
    math.randomseed os.time!
    global.trigger("load")
    global.gravity_y = 0
    global.spawn map global,0,0,20
    global.spawn (player global, global.W/2, global.H/2)
    for i=1,10 do
        global.spawn enemy global, math.random(0,global.W), math.random(0,global.H)
