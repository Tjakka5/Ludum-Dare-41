local Concord = require("lib.concord")
local Vector  = require("lib.vector")

local Transform = Concord.component(function(e, position, rotation, scale)
   e.position = position or Vector(0, 0)
   e.rotation = rotation or 0
   e.scale    = scale    or 5
end)

return Transform