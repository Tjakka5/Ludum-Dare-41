local Concord = require("lib.concord")

local C = require("src.components")

local ShapeRenderer = Concord.system({C.transform, C.shape})

function ShapeRenderer:draw()
   love.graphics.push("all")

   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local transform = e:get(C.transform)
      local shape     = e:get(C.shape)

      if e:has(C.color) then
         local color = e:get(C.color)
         love.graphics.setColor(color.r, color.g, color.b, color.a)
      else
         love.graphics.setColor(1, 1, 1, 1)
      end
   
      love.graphics.push()
      love.graphics.translate(transform.position.x, transform.position.y)
      love.graphics.rotate(transform.rotation)
      love.graphics.scale(transform.scale)

      --love.graphics.setLineWidth(1)
      love.graphics.setLineWidth(1 / transform.scale)
      
      love.graphics.polygon("line", shape.points)

      love.graphics.pop()
   end

   love.graphics.pop()
end

return ShapeRenderer