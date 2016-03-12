local actor = require("core/actor")
local ball
do
  local _parent_0 = actor
  local _base_0 = {
    draw = function(self)
      love.graphics.setColor(200, 50, 50)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end,
    hold_a = function(self)
      self.speed_y = 0
      self.hold = true
    end,
    update = function(self, dt)
      if self.hold then
        self.speed_y = self.speed_y - (self.global.gravity_y * dt)
        self.hold = false
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global)
      return _parent_0.__init(self, global, global.W / 2, global.H / 2, 5, 5)
    end,
    __base = _base_0,
    __name = "ball",
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
  ball = _class_0
end
return ball
