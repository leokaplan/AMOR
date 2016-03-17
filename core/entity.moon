class entity 
    new: (global, x, y) =>
        @global = global
        @x = x
        @y = y
    die: () => @global.kill @
    trigger: (event, ...) => @global.trigger event,unpack{@,...}
    every: (n, f) => @global.every @,n,f
    oneshot: (n, f) => @global.oneshot @,n,f
    spawn: (o) => @global.spawn o
    hud: (f) => @global.hud @,f
    bg: (f) => @global.bg @,f
    cameraScale: (s,v,dt) => 
            cs = @global.camera\getScale!
            @global.camera\setScale(cs + (s-cs)*dt*v)
    cameraPosition: (x,vx,y,vy,dt) =>
            cx,cy = @global.camera\getPosition!
            @global.camera\setPosition(cx +(x-cx)*dt*vx,cy +(y-cy)*dt*vy)
