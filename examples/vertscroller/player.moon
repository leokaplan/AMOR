actor  = require "core/actor"
gun = require "gun"
bullet = require "player_bullet"
--anim8 = require "lib/anim8"
class player extends actor 
    turn: (angle) =>
        @dir = angle
    guard:  => 
        if not @onguard then 
            @onguard = true
            @\oneshot 0.8, -> @onguard = false
    walk: (x,y) => 
        @\move x*@speedx,y*@speedy
    new: (global,x,y) =>
        super global, x, y, 40, 40,nil,"player"
        @speedx = @global.Mcw
        @speedy = @global.Mch
        --@gun = @\equip gun, @w, @h,math.pi/2, bullet
        --@gun2 = @\equip gun, @w/2, @h,math.pi/2, bullet
        -- distance from feet to ground on the top of the jump parabole
        @bulletcolor = {250,50,50}
        @life = 5
        @maxlife = 7
        @onguard = false
    key_hold_a:=> @\walk(-1,0)
    key_hold_d:=> @\walk(1,0)
    key_hold_w:=> @\walk(0,-1)
    key_hold_s:=> @\walk(0,1)
    key_press_j:=> 
        @\turn(math.pi)
        @\trigger("shoot",math.pi)
    key_press_l:=> 
        @\turn(0)
        @\trigger("shoot",0) 
    key_press_i:=> 
        @\turn(-math.pi/2)
        @\trigger("shoot",-math.pi/2) 
    key_press_k:=> 
        @\turn(math.pi/2)
        @\trigger("shoot",math.pi/2) 
    key_press_f:=> @\guard!
    key_press_e:=> if @life < @maxlife then @life += 1 
    key_press_r:=> @life -= 1 
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


    update: (dt) =>
        if @life <= 0 then
            @\die!
        if not @global.camera.locked then
            if @onguard then
                @\cameraScale 1.8, 3, dt
                @\cameraPosition @x,10, @y,10, dt
                --@global.camera\setPosition(@x,@y)
            else
                @\cameraScale 1.5-@life/10, 3, dt
                @\cameraPosition @x,1, @y,1, dt
    
    enter: (o) =>
        --print @\checkcol o
--        @\block(o,{"wall","enemy","boss"})
        if @global.kind(o,"rock") then
               -- print o.__class.__name
                if not @onguard then
                    @life -= 1
                    @hit = true
                    @\oneshot 0.2, -> @hit = false
    
player
