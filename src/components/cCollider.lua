local Concord = require("lib.concord")

local Collider = Concord.component(function(e, size, filter, response)
   e.size     = size or 5
   e.body     = nil
   e.filter   = filter
   e.response = response
end)

return Collider