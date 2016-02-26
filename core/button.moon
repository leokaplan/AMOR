actor  = require "actor"
class button extends actor 
    new: (global,x,y,w,h,callback) =>
        super global,x,y,w/global.Mcw,h/global.Mch
        @callback = callback
    collide: (o) => 
        @callback o
            
    
button 
