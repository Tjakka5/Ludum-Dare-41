local Concord = require("lib.concord")

local Damager = Concord.component(function(e, damage)
   e.damage = damage or 100
   e.hits   = {}
end)

return Damager