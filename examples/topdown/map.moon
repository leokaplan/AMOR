entity  = require "core/entity"
tile = require "tile"
class map extends entity
    new: (global,x,y,size)=>--,size_w,size_h,tile_size) =>
        super global, x,y
        tile_size = 4*@global.Mcw
        for i=0,size-1 do
            for j=0,size-1 do
                @\spawn tile @global,@x+i*tile_size,@y+j*tile_size,tile_size
    
