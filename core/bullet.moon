actor  = require "actor"
class bullet extends actor
    new: (global,x,y,angle) =>
        super global, x,y,1,1
        @angle = angle
    draw: =>
        love.graphics.setColor 255,0,0
        love.graphics.rectangle "fill", @x, @y, @w, @h
    collide: (o) => 
        return true
    update: (dt) =>
        @x += math.cos(@angle)*dt*100
        @y += math.sin(@angle)*dt*100
        if @x < 0 or @x >@global.W then
            --@alive = false
            @\die!
            return true
        if @y < 0 or @y >@global.H then
            --@alive = false
            @=nil
            return true
    
bullet 
