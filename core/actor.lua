local entity = require("core/entity")
local actor
do
  local _parent_0 = entity
  local _base_0 = {
    checkcol = function(self, o)
      local left = o.x < self.x + self.w and self.x + self.w < o.x + o.w
      local right = o.x < self.x and self.x < o.x + o.w
      local up = o.y < self.y + self.h and self.y + self.h < o.y + o.h
      local down = o.y < self.y and self.y < o.y + o.h
      return left, right, up, down
    end,
    block = function(self, o, t)
      local left, right, up, down = self:checkcol(o)
      for k, v in pairs(t) do
        if self.global.kind(o, v) then
          if right and left and up and down then
            print("error")
          end
          if up and down or not (up or down) then
            if right then
              self.x = self.x + self.walk_speed
            elseif left then
              self.x = self.x - self.walk_speed
            end
          end
          if right and left or not (right or left) then
            if up then
              self.y = self.y - self.walk_speed
            elseif down then
              self.y = self.y + self.walk_speed
            end
          end
        end
      end
    end,
    equip = function(self, o, ...)
      return self:spawn(o(self.global, self, ...))
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global, x, y, w, h)
      _parent_0.__init(self, global, x, y)
      self.speed_x = 0
      self.speed_y = 0
      self.w = w * self.global.Mcw
      self.h = h * self.global.Mch
      self.alive = true
    end,
    __base = _base_0,
    __name = "actor",
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
  actor = _class_0
  return _class_0
end
