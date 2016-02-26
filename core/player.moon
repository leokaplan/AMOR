actor  = require "actor"
bullet = require "bullet"
anim8 = require "lib/anim8"
class player extends actor 

    new: (global,x,y) =>
        super global, x, y, 4, 4
        @vy = 0
        @walk_speed = @global.Mcw
        @jump_power = @h*2 
        @\equip gun, @w/2, @h/2, bullet
        -- distance from feet to ground on the top of the jump parabole
        @bulletcolor = {250,50,50}
        @canonw = @global.Mcw
        @canonh = @global.Mch
        @impulse = false
        @alive = true
        @life = 5
        @maxlife = 7
    hold_a:=> @\walk_left!
    hold_d:=> @\walk_right!
    hold_w:=> @\walk_up!
    hold_s:=> @\walk_down!
    press_j:=> @\shoot_left!
    press_l:=>@\shoot_right!
    press_i:=> @\shoot_up!
    press_k:=> @\shoot_down!
    press_f:=> @\guard!
    press_e:=> if @life < @maxlife then @life += 1 
    press_z:=> print @x,@y
        
    canonx: => @x + @w/2
    canony: => @y + @h/2 
    spawn_bullet: =>
        @\spawn bullet @global,@\canonx!-@canonw/2,@\canony!-@canonh/2, @, @dirx,@diry,@bulletcolor

    draw: =>
        --@anim\draw @image, @x, @y,0,@w/@framew, @h/@frameh
        @\hud ->
            love.graphics.setColor 255, 0,0
            love.graphics.rectangle "fill", 0, 0,@life*@global.Mcw , 1*@global.Mch
        @c = {255,255,255}
        if @onguard then
            @c = {200,200,200}
        if @hit then
            @c = {255, 200, 200}
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
        if not @global.camera.locked then
            if @onguard then
                @\cameraScale 1.8, 3, dt
                @\cameraPosition @x,10, @y,10, dt
                --@global.camera\setPosition(@x,@y)
            else
                @\cameraScale 1.5-@life/10, 3, dt
                @\cameraPosition @x,1, @y,1, dt
        if @life <= 0 then
            @global.restart!
        return false
    action: =>
        if not @onguard then
            for k,v in pairs @control do 
                if (love.keyboard.isDown k) then
                    if v.hold then v.hold!
                    if not @key[k] then 
                        @key[k] = true
                        if v.press then v.press!
                else
                    if @key[k] then
                        if v.release then v.release!
                        @key[k] = false
    
    collide: (o) =>
        --print @\checkcol o
        @\block(o,{"wall","enemy","boss"})
        if @global.kind("bullet") then
            if not @global.kind("player_bullet") then
                if not @onguard then
                    @life -= 1
                    @hit = true
                    @\oneshot 0.2, -> @hit = false
                    o.alive = false
        return false
    
player
