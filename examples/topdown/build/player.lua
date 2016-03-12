local actor = require("core/actor")
local gun = require("gun")
local bullet = require("player_bullet")
local player
do
  local _parent_0 = actor
  local _base_0 = {
    turn = function(self, angle)
      self.dir = angle
    end,
    guard = function(self)
      if not self.onguard then
        self.onguard = true
        return self:oneshot(0.8, function()
          self.onguard = false
        end)
      end
    end,
    walk = function(self, x, y)
      self.x = self.x + x
      self.y = self.y + y
    end,
    key_hold_a = function(self)
      return self:walk(-1, 0)
    end,
    key_hold_d = function(self)
      return self:walk(1, 0)
    end,
    key_hold_w = function(self)
      return self:walk(0, -1)
    end,
    key_hold_s = function(self)
      return self:walk(0, 1)
    end,
    key_press_j = function(self)
      self:turn(math.pi)
      return self:trigger("shoot", math.pi)
    end,
    key_press_l = function(self)
      self:turn(0)
      return self:trigger("shoot", 0)
    end,
    key_press_i = function(self)
      self:turn(-math.pi / 2)
      return self:trigger("shoot", -math.pi / 2)
    end,
    key_press_k = function(self)
      self:turn(math.pi / 2)
      return self:trigger("shoot", math.pi / 2)
    end,
    key_press_f = function(self)
      return self:guard()
    end,
    key_press_e = function(self)
      if self.life < self.maxlife then
        self.life = self.life + 1
      end
    end,
    key_press_z = function(self)
      return print(self.x, self.y)
    end,
    draw = function(self)
      self:hud(function()
        love.graphics.setColor(255, 0, 0)
        return love.graphics.rectangle("fill", 0, 0, self.life * self.global.Mcw, 1 * self.global.Mch)
      end)
      self.c = {
        255,
        0,
        255
      }
      if self.onguard then
        self.c = {
          200,
          200,
          200
        }
      end
      if self.hit then
        self.c = {
          255,
          200,
          200
        }
      end
      love.graphics.setColor(self.c)
      return love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    end,
    update = function(self, dt)
      if not self.global.camera.locked then
        if self.onguard then
          self:cameraScale(1.8, 3, dt)
          self:cameraPosition(self.x, 10, self.y, 10, dt)
        else
          self:cameraScale(1.5 - self.life / 10, 3, dt)
          self:cameraPosition(self.x, 1, self.y, 1, dt)
        end
      end
      if self.life <= 0 then
        self.global.restart()
      end
      return false
    end,
    action = function(self)
      if not self.onguard then
        for k, v in pairs(self.control) do
          if (love.keyboard.isDown(k)) then
            if v.hold then
              v.hold()
            end
            if not self.key[k] then
              self.key[k] = true
              if v.press then
                v.press()
              end
            end
          else
            if self.key[k] then
              if v.release then
                v.release()
              end
              self.key[k] = false
            end
          end
        end
      end
    end,
    collide = function(self, o)
      self:block(o, {
        "wall",
        "enemy",
        "boss"
      })
      if self.global.kind(o, "bullet") then
        if not self.global.kind(o, "player_bullet") then
          if not self.onguard then
            self.life = self.life - 1
            self.hit = true
            self:oneshot(0.2, function()
              self.hit = false
            end)
            o.alive = false
          end
        end
      end
      return false
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global, x, y)
      _parent_0.__init(self, global, x, y, 4, 4)
      self.vy = 0
      self.walk_speed = self.global.Mcw
      self.jump_power = self.h * 2
      self.gun = self:equip(gun, self.w, self.h, math.pi / 2, bullet)
      self.bulletcolor = {
        250,
        50,
        50
      }
      self.canonw = self.global.Mcw
      self.canonh = self.global.Mch
      self.alive = true
      self.life = 5
      self.maxlife = 7
      self.onguard = false
    end,
    __base = _base_0,
    __name = "player",
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
  player = _class_0
end
return player
