entity  = require "entity"
class actor extends entity
    walk_right: =>
        @x += @walk_speed
    walk_left: => 
        @x -= @walk_speed
    walk_up: => 
        @y -= @walk_speed
    walk_down: => 
        @y += @walk_speed
    shoot_up: =>
        if not @cooldown then 
            @diry = -1
            @dirx = 0
            @\shoot!
    shoot_down: =>
        if not @cooldown then 
            @diry = 1
            @dirx = 0
            @\shoot!
    shoot_left: =>
        if not @cooldown then 
            @dirx = -1
            @diry = 0
            @\shoot!
    shoot_right: =>
        if not @cooldown then 
            @dirx = 1
            @diry = 0
            @\shoot!
    shoot: => 
        if not @cooldown then 
            if @spawn_bullet then @\spawn_bullet!
            @cooldown = true
            @\oneshot 0.2, -> @cooldown = false
    guard:  => 
        if not @onguard then 
            @c = {}
            @onguard = true
            @\oneshot 0.8, -> @onguard = false
    checkcol: (o) => 
        left = o.x < @x + @w and @x + @w < o.x +o.w 
        right = o.x < @x and @x < o.x +o.w 
        up = o.y < @y + @h and @y + @h < o.y +o.h 
        down = o.y < @y and @y < o.y +o.h 
        return left, right, up, down
    block: (o,t) =>
        left, right, up, down = @\checkcol o
        for k,v in pairs t do 
            if @global.kind(o,v) then
                if right and left and up and down then 
                    print "erro na fisica"
                if up and down or not (up or down)then
                    if right then
                        @x += @walk_speed
                    elseif left then
                        @x -= @walk_speed
                if right and left or not (right or left)then
                    if up then
                        @y -= @walk_speed
                    elseif down then
                        @y += @walk_speed
                        --@y += @walk_speed
                        --@y -= @walk_speed
    new:(global, x, y, w, h) =>
        super global, x, y
        @w = w*@global.Mcw
        @h = h*@global.Mch
        @bulletcolor = {200,100,200}
        @cooldown = false
        @in_ground = false
        @onguard = false
        @alive = true
