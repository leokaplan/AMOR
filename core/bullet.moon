actor  = require "actor"
class bullet extends actor
    new: (global,x,y) =>
        super global, x,y,1,1
    draw: =>
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h
    collide: (o) => 
        if @global.kind(o,"wall") or @global.kind(o,"enemy") then
            return true
            
    
bullet 
