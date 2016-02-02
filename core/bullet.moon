actor  = require "actor"
class bullet extends actor
    new: (global,x,y,parent,dx,dy,color) =>
        @parent = parent
        super global, x,y,1,1
        @speedx = 30*@global.Mcw*dx
        @speedy = 30*@global.Mcw*dy
        @c = color
        @alive = true
    draw: =>
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h


    update: (dt) =>
        @x += @speedx*dt
        @y += @speedy*dt
        if not @alive then
            return true
        return false
    collide: (o) => 
        if o.__class.__name == "wall" or o.__class.__name == "enemy" then
            return true
            
    
bullet 
