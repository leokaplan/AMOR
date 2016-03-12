entity  = require "core/entity"
class tile extends entity
    new: (global, x,y,size) =>
        super global,x,y
        @size = size
        @c = {math.random(0,150),255,math.random(0,150)}
    draw: ()=>
        love.graphics.setColor @c
        love.graphics.rectangle "fill",@x,@y,@size,@size
