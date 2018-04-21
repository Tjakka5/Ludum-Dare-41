local Concord = require("lib.concord")

local function none() end

local Collider = Concord.component(function(e, size, response)
   e.size     = size or 5
   e.body     = nil
   e.response = response or none
end)

return Collider