local Concord = require("lib.concord")
local Vector  = require("lib.vector")

local Body = Concord.component(function(e, velocity, aVelocity, friction, aFriction)
   e.velocity  = velocity  or Vector(0, 0)
   e.aVelocity = aVelocity or 0
   e.friciton  = friction  or 0
   e.aFriction = aFriction or 0
end)

return Body