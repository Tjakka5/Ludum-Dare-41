local Vector = require("lib.vector")

local C = require("src.components")

return function(e, o, delta)
   local transform = e:get(C.transform)
   local body      = e:get(C.body)
   local collider  = e:get(C.collider)

   transform.position:add(delta.x, delta.y)
   
   body.velocity = body.velocity:mirrorOn(Vector(-delta.y, -delta.x))
   collider.body:move(delta.x, delta.y)
end