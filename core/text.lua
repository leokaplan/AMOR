local phantom = require("phantom")
local text
do
  local _parent_0 = phantom
  local _base_0 = {
    update = function(self, dt) end,
    draw = function(self)
      return self:bg(function()
        love.graphics.setColor(self.c)
        return love.graphics.print(self.text, self.x, self.y, 0, self.font_size, self.font_size)
      end)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, global, text, x, y, font_size, color)
      if text == nil then
        text = ""
      end
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      if font_size == nil then
        font_size = 1
      end
      if color == nil then
        color = {
          255,
          255,
          255
        }
      end
      _parent_0.__init(self, global, x, y)
      self.c = color
      self.text = text
      self.font_size = font_size
      return print(self.bg)
    end,
    __base = _base_0,
    __name = "text",
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
  text = _class_0
  return _class_0
end
