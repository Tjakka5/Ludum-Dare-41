local Concord = require("lib.concord")

local C = require("src.components")

local Physics = Concord.system({C.transform, C.body})

function Physics:update(dt)
   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local transform = e:get(C.transform)
      local body      = e:get(C.body)

      local friction = body.velocity:clone()
      friction:mul(-1)
      friction:normalizeInplace()
      friction:mul(body.friciton)
      friction:trimInplace(body.velocity:len())

      local aFriction = -body.aVelocity * body.aFriction
      if aFriction > 0 then aFriction = math.max(0, aFriction) end
      if aFriction < 0 then aFriction = math.min(0, aFriction) end

      body.velocity:add(friction * dt)
      body.aVelocity = body.aVelocity + (aFriction * dt)
      
      transform.position:add(body.velocity * dt)
      transform.rotation = transform.rotation + body.aVelocity * dt
   end
end

return Physics