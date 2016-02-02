global = require "global"
--L1 = require "L_tuto1"
L1 = require "levelbuilder"
love.load = ->
    math.randomseed os.time!
    global.load!
    global.level = 1
    L1 global, 8, 4,{up:0,down:0,left:0,right:0}
love.draw = -> global.draw!
love.update = (dt) -> 
    if global.update dt then 
       love.load! 
    

