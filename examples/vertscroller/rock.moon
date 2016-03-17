actor  = require "core/actor"
class rock extends actor 
    new: (global,x,y,r) =>
        super global, x, y,r,r
        @c = {0,0,255}
    draw: =>
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h

    
rock
