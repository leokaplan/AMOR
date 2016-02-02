## main.moon
    
your main.moon will become main.lua when compiled and will be the file called by love2d.
it should initialize the global context and call the correspondent global function for each love callback. 

a minimal example is provided:
   ```lua
    global = require "global"
    love.load = ->
        global.load!
    love.draw = -> global.draw!
    love.update = (dt) -> 
        if global.update dt then 
            love.load! 
   ```
*ideally* this would be the only file that would interact with love2d 

(which means that you could change the engine at anytime, you would just have to have the equivalent for love.load, love.draw, love.keyboard, love.graphics... and pass them to global)

To not make the learning curve steeper, love functions are used everywhere, but a configuration file redefining the love module should work for porting. 

#### Function notation

```lua
    name_of_the_function(required_argument,
                         required_argument_2, 
                         optional_argument = default_value)
```

description of the function

*warning*: if you take a look at the actual code, the variable names can be different. The code will be updated to follow the documentation.

## global

The global module provides function that make your life easier. It controls basically everything for you so you can just declare a behavior and don't keep track of it after.
#### atributes

`W`,`H`

`level`

`step_x`, `step_y`

#### functions
```lua 
    global.load(width = love.graphics.Width(), 
                height = love.graphics.Height(), 
                step_x = 10,
                step_y = 10,
                gravity_x = 0,
                gravity_y = 0)
```    
initialize the framework, this should be in your love.load function and must be called before the other framework methods.

`width` and `height` are the size of your world (not of your screen), it is also the max zoom out your camera can have.

`step_x` and `step_y` are the horizontal and vertical step size. It is used as a scale factor, collision resolution...

`gravity_x` and `gravity_y` are horizontal and vertical gravity, in steps/sec, so 98*step_y is our notion of gravity 

here the `global.W`, `global.H` (size of the screen) are initialized, the camera is initialized and the `level` is set to **1** 

    every ()

* oneshot
    * spawn
    * kind
    * draw
    ** hud
    ** bg
    * update

## entity

Most classes inherit from the entity class.
It is anything that can be spawn in the world, it will have 

