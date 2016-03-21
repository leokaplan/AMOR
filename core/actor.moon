entity  = require "core/entity"
class actor extends entity
    die: () => 
        @body\destroy! 
        @global.kill @
    equip:(o,...) =>
        @\spawn o @global, @, ...
    move: (x,y) =>
        @body.body\applyLinearImpulse x,y
    new:(global, x, y, w, h,typ,cls,ignores) =>
        super global, x, y
        @speed_y = 0
        @w = w--*@global.Mcw
        @speed_x = 0
        @h = h--*@global.Mch
        @body = {}
        @body.class = cls or "Default"
        --if not @\get classes, cls then
        if not @global.classes then
            @global.classes = {}
            @global.classes["Default"] = true
        if not @global.classes[@body.class] then  
            @global.world\addCollisionClass(@body.class, ignores: ignores or {})
        --    @\set classes, cls, true
            @global.classes[@body.class] = true
        @body.type = typ or "dynamic"
        @body = @global.world\newRectangleCollider(@x,@y,@w,@h,{body_type:@body.type, collision_class:@body.class})
        @body.body\setUserData @
        @alive = true
