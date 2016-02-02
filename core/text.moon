phantom  = require "phantom"
class text extends phantom
    new: (global,text="",x=0,y=0,font_size=1,color={255,255,255}) =>
        super global, x, y
        @c = color 
        @text = text
        @font_size=font_size
        print @bg
    update:(dt) => 
    
    draw: =>
        @\bg ->
            love.graphics.setColor @c
            love.graphics.print @text, @x, @y, 0,@font_size, @font_size

