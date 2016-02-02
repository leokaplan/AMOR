enemy = require "enemy"
class plaperformer extends enemy  
    changedir: =>
        if not @onguard then
            @dir *= -1
            @\walk!
    walk: => 
        if @dir == 1 then @\walk_right!  
        else @\walk_left!
    new: (global,x,y) =>
        super global, x, y, 4, 8
        @vy = 0
        @walk_speed = @global.Mcw
        @jump_power = 4*@global.Mch
        -- distance from feet to ground on the top of the jump parabole
        @dir = -1
        @control = {
            {10,-> @\walk!}
            {1,-> @\guard!}
        }
        @controlsum = 0 
        for k,v in pairs @control do 
            @controlsum += v[1]
        @\every 1, -> @\action!
        @life = 3

    canonx: => @x + @w/2
    canony: => @y + @h/2 
    spawn_bullet: =>
        @\spawn bullet @global, @, @dir,@bulletcolor

    draw: => 
        if not @onguard then
            @c = {50,50,10}
        else
            @c = {200,50,200}
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h
        if @dir == 1 then
            love.graphics.rectangle "fill", @\canonx!, @\canony!, @w, @global.Mch
        else
            love.graphics.rectangle "fill", @\canonx!-@w, @\canony!, @w, @global.Mch


    action: =>
        if not @onguard then
            
            comm = math.random(1,@controlsum)
            count = 1
            for k,v in pairs @control do
                if comm >= count and comm < count + v[1] then
                    @control[k][2]!
                else
                    count += v[1]
    collide: (o) =>
        @\block(o,{"wall","enemy"})
        if @global.kind(o,"wall") then
            left, right, up, down = @\checkcol o
            if (left and not right) or (right and not left) then 
                @\changedir!
        if @global.kind(o,"bullet") and @global.kind(o.parent,"player") then
            @life -= 1
            if @life == 0 then 
                @\die!
                return true
            return false
        --print @@.__name, o.__class.__name
plaperformer
