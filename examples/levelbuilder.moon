
level  = require "level"
player  = require "player"
enemy  = require "enemy"
bg  = require "bg"

class levelbuilder extends level
    new: (global, power, n_enemies,doors) =>
        super global
        W,H,Mcw,Mch = @global.W,@global.H,@global.Mcw,@global.Mch
        @global.init W,H 
        @\spawn bg @global 
        @\spawn player @global, W/2, H/2
        if n_enemies > power
            power = n_enemies
        max_power = math.floor(power/n_enemies)
        while n_enemies != 0
            e_power = math.random 1,max_power
            @\spawn enemy global,W/2,H/4, e_power
            n_enemies -= 1
         

