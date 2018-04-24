local Concord = require("lib.concord")
local Vector  = require("lib.vector")

local Shapes       = require("src.objects.shapes")
local CollResponse = require("src.objects.collResponse")

local C = require("src.components")

return function(x, y)
   local e = Concord.entity()
   :give(C.transform, Vector(x, y), 0, 1)
   :give(C.body, Vector(100, 0), 0, 500, 4)
   :give(C.controls)
   :give(C.collider, 5, CollResponse.bounce)
   :give(C.shape, Shapes.ship_1)
   :give(C.player)
   :give(C.health)
   :give(C.damager)

   return e
end