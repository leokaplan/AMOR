entity  = require "core/entity"
class gun extends entity 
    turn: (angle) =>
        if angle == math.pi then
            @w,@h = 20,10
            @x = @actor.x-@dx+@w 
            @y = @actor.y
        if angle == 0 then 
            @w,@h = 20,10
            @x = @actor.x+@dx 
            @y = @actor.y+@dy-@h
        if angle == -math.pi/2 then 
            @w,@h = 10,20
            @x = @actor.x+@dx-@w 
            @y = @actor.y-@dy+@h 
        if angle == math.pi/2 then 
            @w,@h = 10,20
            @x = @actor.x 
            @y = @actor.y+@dy 
    new:(global,actor,dx,dy,angle,bullet) =>
        super global
        @cooldown = false
        @cooldown_time = 0.2
        @actor = actor
        @dx,@dy = dx,dy
        @dir = angle
        @\turn @dir
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
                @dir = angle
                @\turn @dir
                @\spawn (@.bullet @global,@x,@y,angle)
                @cooldown = true
                @\oneshot 0.2, -> 
                    @cooldown = false
    update: (dt) => 
        @\turn @dir
    draw: => 
        love.graphics.setColor 255,0,200
        love.graphics.rectangle "fill", @x,@y,@w , @h

