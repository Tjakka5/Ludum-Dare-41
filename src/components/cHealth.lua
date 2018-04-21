local Concord = require("lib.concord")

local Health = Concord.component(function(e, health)
   e.health    = health or 100
   e.maxHealth = health or 100
end)

return Health