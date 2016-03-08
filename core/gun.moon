entity  = require "entity"
class gun extends entity 
    new:(global,actor,dx,dy,bullet) =>
        super global
        @cooldown = false
        @cooldown_time = 0.2
        @actor = actor
        @dx,@dy = dx,dy
        @x = @actor.x+@dx 
        @y = @actor.y+@dy 
        @w,@h = 10,20
        @bullet = bullet
        @bullet_color = {255,0,0}
        @alive = true
    change_bullet: (bullet,color) =>
        @bullet = bullet or @bullet
        @bullet_color = color or @bullet_color
    shoot: (actor,angle)=>
        if actor == @actor then
            if not @cooldown then 
                print "shoot"
                @\spawn (@.bullet @global,@x,@y,angle)
                @cooldown = true
                @\oneshot 0.2, -> 
                    @cooldown = false
    update: (dt) => 
        @x = @actor.x + @dx
        @y = @actor.y + @dy
    draw: => 
        love.graphics.setColor 255,0,200
        love.graphics.rectangle "fill", @x,@y,@w , @h

