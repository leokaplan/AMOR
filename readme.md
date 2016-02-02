AMÖR
===


# What is it

AMÖR is a functional game development framework written in [moonscript](http://moonscript.org/) that uses [love2d](http://love2d.org/) as environment.  

# Quick start

* Linux (Ubuntu 14.04)

        $ sudo apt-get install lua love luarocks
        $ git clone 
        $ cd amor/
        amor $ luarocks install moonscript
        amor $ cd demos/sidescroller/
        amor/demos/sidescroller $ make run


# Philosophy

The idea is to create entities that live together in a world, which is orchestrated by the global context.

Each entity implements it's functions such as load, update, keypressed, draw, etc.. and they will be propagated automatically.

The entities have to power to spawn a new entity, but not to kill others: Once spawned, an entity takes care of itself. 

    Eg: a level spawns some walls and a player. The player will spawn bullets every time the space bar is pressed. The bullet will kill itself when it collides with a wall or go away from the screen.



The global context started with the idea that collateral effects can be a source of bugs, because it is hard to track the origin of a behavior. 

Each entity has a local context and react to events such as update, draw or keypresses independently. 

But entities in the world should be able to react to other signals emmited by other entities, to achieve that we pass a `global` shared reference to every object. It is a singleton that is shared through everything. It provides callbacks such as `collide`. 

In a few words:

* One entity should not interfere in the internal state of the other, so a bullet should kill itself when it collides with a wall, instead of the wall killing it.
* This allows an easier debugging since the reason of an unexpected behavior of the entity X will be always inside the X class.
* The global class orchestrates all the timers, drawcalls, collisions and etc.

The entities are inspired by the organisms of [Céu](http://www.ceu-lang.org/)

# Compatibility

For now efforts will just be made to be compatible with love 0.10

# Class tree
* entity
  * level
  * phantom
    * bg 
  * text
  * wall
  * actor
    * player
    * enemy
  * button
  * bullet

check the documentation!

## Todo
   
    More documentation
    separate generic from specific code
    auto make and build
    tests
    UI
    family functions in global (descendent, ascendant) no relative, all are relative
    an interface for creating events
    collisions with HC
    animations with anim8
    
## libs integrations:    
     
    lights with lightandshadow (need fixes for 0.10)
    camera with gamera
    timers with cron


