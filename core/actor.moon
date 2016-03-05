entity  = require "entity"
class actor extends entity
    checkcol: (o) => 
        left = o.x < @x + @w and @x + @w < o.x +o.w 
        right = o.x < @x and @x < o.x +o.w 
        up = o.y < @y + @h and @y + @h < o.y +o.h 
        down = o.y < @y and @y < o.y +o.h 
        return left, right, up, down
    block: (o,t) =>
        left, right, up, down = @\checkcol o
        for k,v in pairs t do 
            if @global.kind(o,v) then
                if right and left and up and down then 
                    print "error"
                if up and down or not (up or down)then
                    if right then
                        @x += @walk_speed
                    elseif left then
                        @x -= @walk_speed
                if right and left or not (right or left)then
                    if up then
                        @y -= @walk_speed
                    elseif down then
                        @y += @walk_speed
                        --@y += @walk_speed
                        --@y -= @walk_speed
    equip:(o,...) =>
        @\spawn o @global, @, ...
    new:(global, x, y, w, h) =>
        super global, x, y
        @speed_x = 0
        @speed_y = 0
        @w = w*@global.Mcw
        @h = h*@global.Mch
        @alive = true
