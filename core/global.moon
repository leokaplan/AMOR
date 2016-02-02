libdir = "../lib/"
cron = require libdir.."cron"
gamera = require libdir.."gamera"
--require "lib/light"

global = {}
global.level = 0
global.objs = {}
global.timers = {}
global.ui = {}
global.background = {}
global.load = ->
    --global.ground = global.H*7/8
    global.init = (w,h,gx,gy) ->
        global.W, global.H = love.graphics.getDimensions!
        global.gravityx = gx or 0
        global.gravityy = gy or 98*global.Mch
        w = w or global.W
        h = h or global.H
        global.camera = gamera.new 0, 0 , w,h
        global.Mcw = 10
        global.Mch = 10
        global.level = 1

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
    global.restart = -> 
        print "restart"
        global.level = 0

    global.hud = (o, f) -> table.insert global.ui, {o, f}
    global.bg = (o, f) -> table.insert global.background, {o, f}
    global.draw = ->
        global.camera\draw (l,t,w,h)->
                love.graphics.setColor 255, 255, 255
                love.graphics.rectangle "fill", 0, 0, love.graphics.getWidth!*2, love.graphics.getHeight!
                for k,v in pairs global.background do 
                        v[2]!
                for i,o in pairs global.objs do 
                    if o.draw then o\draw!
       
        for k,v in pairs global.ui do 
            if v[1].alive then
                v[2]!
            else
                global.ui[k] = nil
    
    
    
    collision = (a,b) -> 
        a.x < b.x + b.w and 
        b.x < a.x + a.w and 
        a.y < b.y + b.h and
        b.y < a.y + a.h 

    global.update = (dt) ->
        if global.level == 0 then
            return true
        if global.camera.locked then
            global.camera.locked global,dt
        cs = global.camera\getScale!
        cx,cy = global.camera\getPosition!
         
        lx = (global.W-2*cs*cx)*(1/cs)
        ly = (global.H-2*cs*cy)*(1/cs)
        for k,v in pairs global.timers do 
            if v[1].alive then
                if v[2]\update dt then
                    global.timers[k] = nil
            else
                global.timers[k] = nil
        
        for i,o in pairs global.objs do
            if o.update and o\update dt then
                global.objs[i] = nil
        for i,o in pairs global.objs do
            for k,v in next,global.objs,i do
                if o and v and o ~= v then
                    if not (global.kind(o,"phantom") or global.kind(v,"phantom")) then
                        if collision(o,v) then
                            ro = o\collide v            
                            rv = v\collide o
                            if ro then 
                                global.objs[i] = nil
                                --o = nil
                            if rv then 
                                global.objs[k] = nil
                                --v = nil
global
