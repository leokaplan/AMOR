entity  = require "entity"
wall  = require "wall"
class level extends entity 
    new: (global) =>
        super global,0,0
    create_wall: (x,y,w,h) => 
        @\spawn wall @global,x,y,w,h,{100,200,100}

