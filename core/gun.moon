class gun extends item
    new:(global,actor,dx,dy,bullet) =>
        super global
        @cooldown = false
        @cooldown_time = 0.2
        @actor = actor
        @x,@y = dx,dy
        @bullet = bullet
        @bullet_color = {255,0,0}
    change_bullet: (bullet,color) =>
        @bullet = bullet or @bullet
        @bullet_color = color or @bullet_color
    shoot: => 
        if not @cooldown then 
            @\spawn @bullet @global @x,@y,@angle
            @cooldown = true
            @\oneshot @cooldown_time, -> @cooldown = false
    update: (dt) => 
        @x += @actor.speed_x*dt
        @y += @actor.speed_y*dt

