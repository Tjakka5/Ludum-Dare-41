local Concord = require("lib.concord")
local Vector  = require("lib.vector")

local C = require("src.components")

local Input = Concord.system({C.controls})

function Input:update(dt)
   dt = dt * DT_MULTIPLIER

   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local controls  = e:get(C.controls)
      local transform = e:get(C.transform)
      local body      = e:get(C.body)
      
      if transform and body then
         local movement = Vector(0, 0)
         local aMovement = 0

         if love.keyboard.isDown(controls.up)    then movement.y = movement.y - 1 end
         if love.keyboard.isDown(controls.down)  then movement.y = movement.y + 1 end
         if love.keyboard.isDown(controls.left)  then aMovement = aMovement - 1 end
         if love.keyboard.isDown(controls.right) then aMovement = aMovement + 1 end

         movement:mul(600)
         aMovement = aMovement * 30

         movement:rotateInplace(transform.rotation)

         body.velocity:add(movement * dt)
         body.aVelocity = body.aVelocity + aMovement * dt
      end
   end
end

return Input