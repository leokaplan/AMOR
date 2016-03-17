entity = require "core/entity"
player = require "player"
wall = require "wall"
rock = require "rock"
class level extends entity
    new:(global)=>
        super global,0,0
    load:=>
        @\spawn player @global,@global.W/2,@global.H/2
        @\spawn wall @global,0,@global.H-20,@global.W,20
        --@\spawn wall @global,0,@global.H-20,@global.W,20
        --@\spawn wall @global,0,@global.H-20,@global.W,20
        @\every 0.05, -> 
            @\spawn rock @global, math.random(0,@global.W),0,2
