
actor  = require "core/actor"
gun = require "gun"
bullet = require "player_bullet"
--anim8 = require "lib/anim8"
class enemy extends actor 
    turn: (angle) =>
        @dir = angle
    guard:  => 
        if not @onguard then 
            @onguard = true
            @\oneshot 0.8, -> @onguard = false
    walk: (x,y) => 
        @x += x
        @y += y
    new: (global,x,y) =>
        print "oi"
        super global, x, y, 4, 4
        @walk_speed = @global.Mcw
        @jump_power = @h*2 
        --@gun = @\equip gun, @w, @h,math.pi/2, bullet
        -- distance from feet to ground on the top of the jump parabole
        @bulletcolor = {250,50,50}
        @alive = true
        @life = 5
        @maxlife = 7
        @onguard = false
        @speed = 10
        @action = {
            => @speed_x = @speed,
            => @speed_y = @speed,
            => @speed_x = -@speed,
            => @speed_y = -@speed,
            => @speed_x = 0,
            => @speed_y = 0
        }
        @\every 0.3, -> 
            ran = math.random(1,#@action)
            @action[ran] @  
        
    draw: =>
        mod = (@maxlife-@life)/@maxlife
        @c = {255*mod,255/2,255*mod}
        if @hit then
            @c[1] = 255
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h


         
    collide: (o) =>
        --print @\checkcol o
        @\block(o,{"wall","enemy","boss"})
        if @global.kind(o,"bullet") then
                    @life -= 1
                    if @life == 0 then
                        @\die!
                    @hit = true
                    @\oneshot 0.2, -> @hit = false
    
