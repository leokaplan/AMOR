local entity = require("core/entity")
local gun
do
  local _parent_0 = entity
  local _base_0 = {
    turn = function(self, angle)
      if angle == math.pi then
        self.w, self.h = 20, 10
        self.x = self.actor.x - self.dx + self.w
        self.y = self.actor.y
      end
      if angle == 0 then
        self.w, self.h = 20, 10
        self.x = self.actor.x + self.dx
        self.y = self.actor.y + self.dy - self.h
      end
      if angle == -math.pi / 2 then
        self.w, self.h = 10, 20
        self.x = self.actor.x + self.dx - self.w
        self.y = self.actor.y - self.dy + self.h
      end
      if angle == math.pi / 2 then
        self.w, self.h = 10, 20
        self.x = self.actor.x
        self.y = self.actor.y + self.dy
      end
    end,
    change_bullet = function(self, bullet, color)
      self.bullet = bullet or self.bullet
      self.bullet_color = color or self.bullet_color
    end,
    shoot = function(self, actor, angle)
      if actor == self.actor then
        if not self.cooldown then
          self.dir = angle
          self:turn(self.dir)
          self:spawn((self.bullet(self.global, self.x, self.y, angle)))
          self.cooldown = true
          return self:oneshot(0.2, function()
            self.cooldown = false
          end)
        end
      end
    end,
    update = function(self, dt)
      return self:turn(self.dir)
    end,
    draw = function(self)
      love.graphics.setColor(255, 0, 200)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global, actor, dx, dy, angle, bullet)
      _parent_0.__init(self, global)
      self.cooldown = false
      self.cooldown_time = 0.2
      self.actor = actor
      self.dx, self.dy = dx, dy
      self.dir = angle
      self:turn(self.dir)
      self.w, self.h = 10, 20
      self.bullet = bullet
      self.bullet_color = {
        255,
        0,
        0
      }
      self.alive = true
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
