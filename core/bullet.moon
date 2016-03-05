actor  = require "actor"
class bullet extends actor
    new: (global,x,y,angle) =>
        super global, x,y,1,1
        @angle = angle
    draw: =>
        love.graphics.setColor 255,0,0
        love.graphics.rectangle "fill", @x, @y, @w, @h
    collide: (o) => 
        if @global.kind(o,"wall") or @global.kind(o,"enemy") then
            return true
    update: (dt) =>
        @x += math.cos(@angle)
        @y += math.sin(@angle)
    
bullet 
