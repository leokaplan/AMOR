local actor = require("actor")
local button
do
  local _parent_0 = actor
  local _base_0 = {
    collide = function(self, o)
      return self:callback(o)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global, x, y, w, h, callback)
      _parent_0.__init(self, global, x, y, w / global.Mcw, h / global.Mch)
      self.callback = callback
    end,
    __base = _base_0,
    __name = "button",
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
  button = _class_0
end
return button
