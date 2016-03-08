actor  = require "actor"
gun = require "gun"
bullet = require "player_bullet"
--anim8 = require "lib/anim8"
class player extends actor 
    guard:  => 
        if not @onguard then 
            @onguard = true
            @\oneshot 0.8, -> @onguard = false
    walk: (x,y) => 
        @x += x
        @y += y
    new: (global,x,y) =>
        super global, x, y, 4, 4
        @vy = 0
        @walk_speed = @global.Mcw
        @jump_power = @h*2 
        @gun = @\equip gun, @w, @h, bullet
        -- distance from feet to ground on the top of the jump parabole
        @bulletcolor = {250,50,50}
        @canonw = @global.Mcw
        @canonh = @global.Mch
        @alive = true
        @life = 5
        @maxlife = 7
        @onguard = false
    key_hold_a:=> @\walk(-1,0)
    key_hold_d:=> @\walk(1,0)
    key_hold_w:=> @\walk(0,-1)
    key_hold_s:=> @\walk(0,1)
    key_press_j:=> @\trigger("shoot",math.pi)
    key_press_l:=> @\trigger("shoot",0) 
    key_press_i:=> @\trigger("shoot",-math.pi/2) 
    key_press_k:=> @\trigger("shoot",math.pi/2) 
    key_press_f:=> @\guard!
    key_press_e:=> if @life < @maxlife then @life += 1 
    key_press_z:=> print @x,@y
        
    draw: =>
        --@anim\draw @image, @x, @y,0,@w/@framew, @h/@frameh
        @\hud ->
            love.graphics.setColor 255, 0,0
            love.graphics.rectangle "fill", 0, 0,@life*@global.Mcw , 1*@global.Mch
        @c = {255,0,255}
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
        if @global.kind(o,"bullet") then
            if not @global.kind(o,"player_bullet") then
                if not @onguard then
                    @life -= 1
                    @hit = true
                    @\oneshot 0.2, -> @hit = false
                    o.alive = false
        return false
    
player
