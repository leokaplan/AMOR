currdir = ""
libdir = currdir.."core/lib/"
--TODO:fix this require, should be:
--cron = require libdir.."cron"
gamera = require libdir.."gamera/gamera"
cron = require libdir.."cron/cron"
hx = require libdir..'hxdx/hxdx'
--HC = require libdir.."HC"
--require "lib/light"
global = {}
global.level = 0
global.objs = {}
global.key = {}
global.timers = {}
global.ui = {}
global.background = {}
global.load = -> global.init global.w,global.h,global.gravity_x,global.gravity_y
    --global.ground = global.H*7/8
global.init = (w,h,gx,gy) ->
    global.W, global.H = love.graphics.getDimensions!
    global.Mcw = 10
    global.Mch = 10
    global.gravity_x = gx or 0
    global.gravity_y = gy or 9.8*global.Mch
    w = w or global.W
    h = h or global.H
    global.camera = gamera.new 0, 0 , w,h
    global.level = 1
    global.world = hx.newWorld {gravity_y: global.gravity_y}--math.max(global.Mcw,global.Mch))


global.kind = (o,k) -> 
    if o.__class.__name == k then 
        return true
    else 
        if o.__class.__parent then 
            return global.kind(o.__class.__parent,k)
        else
            return false




global.every = (o, n, f) -> table.insert global.timers, {o, cron.every n, f}
global.oneshot = (o, n, f) -> table.insert global.timers, {o, cron.after n, f}
global.spawn = (o) -> 
    table.insert global.objs, o
    return o
global.keypressed = (key,scancode,isrepeat) -> 
    global.key[key] = true
    global.trigger("key_press_"..key,isrepeat)
global.keyreleased = (key,scancode,isrepeat) -> 
    global.key[key] = nil
    global.trigger("key_release_"..key,isrepeat)

global.trigger = (evt,...) ->
    if global[evt] then global[evt](...)
    global.propagate(evt,...)
global.propagate = (evt,...) ->    
    for i,o in pairs global.objs do
        if o[evt] then
            o[evt](o,...)

global.hud = (o, f) -> table.insert global.ui, {o, f}
global.bg = (o, f) -> table.insert global.background, {o, f}
global.draw = ->
    
    global.camera\draw (l,t,w,h)->
            love.graphics.setColor 255, 255, 255
            love.graphics.rectangle "fill", 0, 0, love.graphics.getWidth!*2, love.graphics.getHeight!
            for k,v in pairs global.background do 
                    v[2]!
            global.propagate("draw") 
            if global.debug then
                global.world\draw!
    for k,v in pairs global.ui do 
        if v[1].alive then
            v[2]!
        else
            global.ui[k] = nil
    if global.debug then
        love.graphics.setColor 100, 100,100
        love.graphics.print love.timer.getFPS!,10,10
        love.graphics.print #global.objs.." "..#global.timers,10,20
        i = 0
        for k,v in pairs(global.objs) do
            love.graphics.print k.." "..v.__class.__name,global.W-100,20+i*10
            i+=1



collision = (a,b) -> 
    a.x < b.x + b.w and 
    b.x < a.x + a.w and 
    a.y < b.y + b.h and
    b.y < a.y + a.h 

global.kill = (o) ->
    for k,v in pairs(global.objs) do
        if v == o then
            global.objs[k] = nil

global.update = (dt) ->
    if global.level == 0 then
        return true
    if global.camera.locked then
        global.camera.locked global,dt
    cs = global.camera\getScale!
    cx,cy = global.camera\getPosition!
     
    lx = (global.W-2*cs*cx)*(1/cs)
    ly = (global.H-2*cs*cy)*(1/cs)
    for k,v in pairs global.key do
        global.trigger("key_hold_"..k)
    for k,v in pairs global.timers do 
        if global.kind(v[1],"entity") then
            if v[2]\update dt then
                global.timers[k] = nil
        else
            global.timers[k] = nil
    
    global.world\update(dt)
    for i,o in pairs global.objs do
        --if it is a physical being
        if global.kind(o,"actor") then
            x,y = o.body.body\getPosition!
            col = global.world\queryRectangleArea(x, y, o.w, o.h)
            o.x,o.y = x-o.w/2,y-o.h/2 
            --if #col > 0 then 
                --print o.__class.__name,#col
            for k,v in pairs col do
                if o and v then
                        if v.body then 
                            actor = v.body\getUserData!            
                            if o.enter then
                                o\enter actor
                            if actor.enter then
                                actor\enter o
                     
--            for k,v in pairs global.objs do
--                if global.kind(v,"actor") then
                        --resolve collision
                        
                        --if o and o.body and o.body\enter(v.body.collision_class) then

--                            if o.enter then
--                                ro = o\enter v            
--                        if o and o.body and o.body\exit(v.body.collision_class) then
--                            if o.exit then
--                                ro = o\exit v            

global
