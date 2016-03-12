local entity = require("entity")
local wall = require("wall")
local level
do
  local _parent_0 = entity
  local _base_0 = {
    create_wall = function(self, x, y, w, h)
      return self:spawn(wall(self.global, x, y, w, h, {
        100,
        200,
        100
      }))
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global)
      return _parent_0.__init(self, global, 0, 0)
    end,
    __base = _base_0,
    __name = "level",
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
  level = _class_0
  return _class_0
end
