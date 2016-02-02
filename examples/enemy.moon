actor  = require "actor"
bullet = require "bullet"
class enemy extends actor  
    die: =>
        @alive = false 
    
    new: (global,x,y,power) =>
        super global, x, y, 4, 4
        @vy = 0
        @power = power
        @walk_speed = @global.Mcw
        -- distance from feet to ground on the top of the jump parabole
        @dirx = -1
        @diry = 0
        @control = {
            {0,-> @\guard!}
            {7,-> @\walk_right!}
            {5,-> @\walk_left!}
            {5,-> @\walk_up!}
            {5,-> @\walk_down!}
            {3,-> @\shoot!}
        }
        @controlsum = 0 
        for k,v in pairs @control do 
            @controlsum += v[1]
        @\every 0.1, -> @\action!
        @maxlife = power
        @life = @maxlife
        @canonw = @global.Mcw
        @canonh = @global.Mch

    canonx: => @x + @w/2
    canony: => @y + @h/2 
    spawn_bullet: =>
        @\spawn bullet @global,@\canonx!-@canonw/2,@\canony!-@canonh/2, @, @dirx,@diry,@bulletcolor

    draw: => 
        n_life = @life/@maxlife
        @c = {100*@power*n_life,100*@power*n_life,100*@power*n_life}
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h
        if @dirx == 1 then
            love.graphics.rectangle "fill", @\canonx!, @\canony!-@canonh/2, @w, @global.Mch
        elseif @dirx == -1 then
            love.graphics.rectangle "fill", @\canonx!-@w, @\canony!-@canonh/2, @w, @global.Mch
        elseif @diry == 1 then
            love.graphics.rectangle "fill", @\canonx!-@canonw/2, @\canony!, @global.Mcw, @h
        elseif @diry == -1 then
            love.graphics.rectangle "fill", @\canonx!-@canonw/2, @\canony!-@h, @global.Mcw, @h




    update: (dt) =>
        if not @alive then
            return true
        return false
    action: =>
        if not @onguard then
            
            comm = math.random(1,@controlsum)
            count = 1
            for k,v in pairs @control do
                if comm >= count and comm < count + v[1] then
                    @control[k][2]!
                    break
                else
                    count += v[1]
    collide: (o) =>
        @\block(o,{"wall","enemy"})
        if @global.kind(o,"bullet") and @global.kind(o.parent,"player") then
            @life -= 1
            if @life == 0 then 
                @\die!
                return true
            return false
        --print @@.__name, o.__class.__name
enemy
