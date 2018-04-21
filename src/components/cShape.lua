local Concord = require("lib.concord")

local Shape = Concord.component(function(e, points)
   e.points = points
end)

return Shape