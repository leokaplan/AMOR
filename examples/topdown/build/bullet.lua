local actor = require("core/actor")
local bullet
do
  local _parent_0 = actor
  local _base_0 = {
    draw = function(self)
      love.graphics.setColor(255, 0, 0)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end,
    collide = function(self, o)
      return true
    end,
    update = function(self, dt)
      self.x = self.x + (math.cos(self.angle) * dt * 500)
      self.y = self.y + (math.sin(self.angle) * dt * 500)
      if self.x < 0 or self.x > self.global.W then
        self:die()
      end
      if self.y < 0 or self.y > self.global.H then
        return self:die()
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global, x, y, angle)
      _parent_0.__init(self, global, x, y, 1, 1)
      self.angle = angle
    end,
    __base = _base_0,
    __name = "bullet",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  bullet = _class_0
end
return bullet
