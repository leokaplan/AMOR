local shield
do
  local _parent_0 = item
  local _base_0 = {
    guard = function(self)
      if not self.onguard then
        self.onguard = true
        return self:oneshot(0.8, function()
          self.onguard = false
        end)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global)
      _parent_0.__init(self, global)
      self.onguard = false
    end,
    __base = _base_0,
    __name = "shield",
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
  shield = _class_0
  return _class_0
end
