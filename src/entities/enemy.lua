local Concord = require("lib.concord")
local Vector  = require("lib.vector")

local Shapes       = require("src.objects.shapes")
local CollResponse = require("src.objects.collResponse")

local C = require("src.components")

return function( x, y)
   local e = Concord.entity()
   :give(C.transform, Vector(x, y), 0, 1)
   :give(C.body, Vector(love.math.random(0, 50), 50), 0, 500, 4)
   :give(C.collider, 5)
   :give(C.shape, Shapes.ship_2)
   :give(C.player)
   :give(C.health)

   return e
end