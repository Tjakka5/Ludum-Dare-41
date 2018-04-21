local Concord = require("lib.concord")

local Color = Concord.component(function(e, r, g, b, a)
   e.r = r
   e.g = g
   e.b = b
   e.a = a
end)

return Color