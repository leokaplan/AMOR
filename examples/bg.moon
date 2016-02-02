phantom  = require "phantom"
class bg extends phantom
    new: (global) =>
        super global, 0,0
        @\bg ->
            love.graphics.setColor {0,0,0}
            love.graphics.rectangle "fill", @x, @y, @global.W, @global.H

