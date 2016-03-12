local entity
do
  local _base_0 = {
    die = function(self)
      return self.global.kill(self)
    end,
    trigger = function(self, event, ...)
      return self.global.trigger(event, unpack({
        self,
        ...
      }))
    end,
    every = function(self, n, f)
      return self.global.every(self, n, f)
    end,
    oneshot = function(self, n, f)
      return self.global.oneshot(self, n, f)
    end,
    spawn = function(self, o)
      return self.global.spawn(o)
    end,
    hud = function(self, f)
      return self.global.hud(self, f)
    end,
    bg = function(self, f)
      return self.global.bg(self, f)
    end,
    cameraScale = function(self, s, v, dt)
      local cs = self.global.camera:getScale()
      return self.global.camera:setScale(cs + (s - cs) * dt * v)
    end,
    cameraPosition = function(self, x, vx, y, vy, dt)
      local cx, cy = self.global.camera:getPosition()
      return self.global.camera:setPosition(cx + (x - cx) * dt * vx, cy + (y - cy) * dt * vy)
    end
  }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function(self, global, x, y)
      self.global = global
      self.x = x
      self.y = y
    end,
    __base = _base_0,
    __name = "entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  entity = _class_0
  return _class_0
end
