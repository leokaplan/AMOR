actor  = require "core/actor"
class rock extends actor 
    new: (global,x,y,r) =>
        super global, x, y,r,r,nil,"rock"
        @c = {0,0,255}
    draw: =>
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h
    enter: (o)=>
        if not @global.kind(o,"rock") then
            @\die!
        
    
rock
