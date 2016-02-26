actor  = require "actor"
class ball extends actor
    new: (global) =>
        super global, global.W/2,global.H/2,5,5
    draw: =>
        love.graphics.setColor 200,50,50
        love.graphics.rectangle "fill", @x, @y, @w, @h
    --keypressed_a: => 
    --keyreleased_a: => 
    hold_a: => 
        @speed_y = 0
        @hold = true
        
    update: (dt) =>
        if @hold then
            @speed_y -= @global.gravity_y*dt
            @hold = false
ball 
