actor  = require "actor"
class button extends actor 
    new: (global,x,y,w,h,callback) =>
        super global,x,y,w/global.Mcw,h/global.Mch
        @alive = true
        @callback = callback
    --draw: =>
        --love.graphics.setColor 255,255,255
        --love.graphics.rectangle "fill", @x, @y, @w, @h


    update: (dt) =>
        if not @alive then
            return true
        return false
    collide: (o) => 
        @callback o
            
    
button 
