local wall
do
  local _base_0 = {
    draw = function(self)
      love.graphics.setColor(self.c)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end,
    update = function(self, dt)
      return false
    end,
    collide = function(self, o)
      return false
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, global, x, y, w, h, c)
      self.global = global
      self.x = x
      self.y = y
      self.w = w
      self.h = h
      self.c = c
    end,
    __base = _base_0,
    __name = "wall"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  wall = _class_0
end
return wall
