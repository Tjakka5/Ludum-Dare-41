local Concord = require("lib.concord")
local HCamera = require("lib.camera")

local C = require("src.components")

local Camera = Concord.system({C.none})

local function lerp(v1, v2, t)
   return v1 * (1 - t) + v2 * t
end

function Camera:init(target)
   local x, y = 0, 0

   if target and target:has(C.transform) then
      x, y = target:get(C.transform).position:unpack()
   end

   self.cam      = HCamera(x, y, 3, 0)
   self.smoother = HCamera.smooth.linear(2500)
   self.target   = target 
end

function Camera:update(dt)
   dt = dt * DT_MULTIPLIER
   
   local target = self.target

   if target then
      local transform = target:get(C.transform)

      if transform then
         local tx, ty = transform.position:unpack()
         self.cam:lookAt(tx, ty)
      end
   end
end

function Camera:attach()
   self.cam:attach()
end

function Camera:detach()
   self.cam:detach()
end

return Camera