local gun
do
  local _parent_0 = item
  local _base_0 = {
    change_bullet = function(self, bullet, color)
      self.bullet = bullet or self.bullet
      self.bullet_color = color or self.bullet_color
    end,
    shoot = function(self)
      if not self.cooldown then
        self:spawn(self:bullet(self:global(self.x, self.y, self.angle)))
        self.cooldown = true
        return self:oneshot(self.cooldown_time, function()
          self.cooldown = false
        end)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global, bullet)
      _parent_0.__init(self, global)
      self.cooldown = false
      self.cooldown_time = 0.2
      self.bullet = bullet
      self.bullet_color = {
        255,
        0,
        0
      }
    end,
    __base = _base_0,
    __name = "gun",
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
  gun = _class_0
  return _class_0
end
