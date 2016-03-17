actor  = require "core/actor"
class wall extends actor 
    new: (global,x,y,w,h) =>
        super global, x, y,w,h,"static"
        @c = {0,255,0}
    update: (dt) =>

    draw: =>
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h

    
wall
