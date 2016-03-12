local currdir = ""--love.filesystem.getWorkingDirectory()
local libdir = currdir .. "core/lib/"
local gamera = require(libdir .. "gamera/gamera")
local cron = require(libdir .. "cron/cron")
local global = { }
global.level = 0
global.objs = { }
global.key = { }
global.timers = { }
global.ui = { }
global.background = { }
global.load = function()
  return global.init()
end
global.init = function(w, h, gx, gy)
  global.W, global.H = love.graphics.getDimensions()
  global.Mcw = 10
  global.Mch = 10
  global.gravity_x = gx or 0
  global.gravity_y = gy or 98 * global.Mch
  w = w or global.W
  h = h or global.H
  global.camera = gamera.new(0, 0, w, h)
  global.level = 1
end
global.kind = function(o, k)
  if o.__class.__name == k then
    return true
  else
    if o.__class.__parent then
      return global.kind(o.__class.__parent, k)
    else
      return false
    end
  end
end
global.every = function(o, n, f)
  return table.insert(global.timers, {
    o,
    cron.every(n, f)
  })
end
global.oneshot = function(o, n, f)
  return table.insert(global.timers, {
    o,
    cron.after(n, f)
  })
end
global.spawn = function(o)
  table.insert(global.objs, o)
  return o
end
global.keypressed = function(key, scancode, isrepeat)
  global.key[key] = true
  return global.trigger("key_press_" .. key, isrepeat)
end
global.keyreleased = function(key, scancode, isrepeat)
  global.key[key] = nil
  return global.trigger("key_release_" .. key, isrepeat)
end
global.trigger = function(evt, ...)
  if global[evt] then
    global[evt](...)
  end
  return global.propagate(evt, ...)
end
global.propagate = function(evt, ...)
  for i, o in pairs(global.objs) do
    if o[evt] then
      o[evt](o, ...)
    end
  end
end
global.hud = function(o, f)
  return table.insert(global.ui, {
    o,
    f
  })
end
global.bg = function(o, f)
  return table.insert(global.background, {
    o,
    f
  })
end
global.draw = function()
  global.camera:draw(function(l, t, w, h)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth() * 2, love.graphics.getHeight())
    for k, v in pairs(global.background) do
      v[2]()
    end
    return global.propagate("draw")
  end)
  for k, v in pairs(global.ui) do
    if v[1].alive then
      v[2]()
    else
      global.ui[k] = nil
    end
  end
end
local collision
collision = function(a, b)
  return a.x < b.x + b.w and b.x < a.x + a.w and a.y < b.y + b.h and b.y < a.y + a.h
end
global.kill = function(o)
  for k, v in pairs(global.objs) do
    if v == o then
      global.objs[k] = nil
    end
  end
end
global.update = function(dt)
  if global.level == 0 then
    return true
  end
  if global.camera.locked then
    global.camera.locked(global, dt)
  end
  local cs = global.camera:getScale()
  local cx, cy = global.camera:getPosition()
  local lx = (global.W - 2 * cs * cx) * (1 / cs)
  local ly = (global.H - 2 * cs * cy) * (1 / cs)
  for k, v in pairs(global.key) do
    global.trigger("key_hold_" .. k)
  end
  for k, v in pairs(global.timers) do
    if v[1].alive then
      if v[2]:update(dt) then
        global.timers[k] = nil
      end
    else
      global.timers[k] = nil
    end
  end
  for i, o in pairs(global.objs) do
    if global.kind(o, "actor") then
      o.speed_x = o.speed_x + (global.gravity_x * dt)
      o.speed_y = o.speed_y + (global.gravity_y * dt)
      o.x = o.x + (o.speed_x * dt)
      o.y = o.y + (o.speed_y * dt)
      for k, v in next,global.objs,i do
        if global.kind(v, "actor") then
          if o and v and o ~= v then
            if collision(o, v) then
              local ro = o:collide(v)
              local rv = v:collide(o)
              if ro then
                global.objs[i] = nil
              end
              if rv then
                global.objs[k] = nil
              end
            end
          end
        end
      end
    end
  end
end
return global
