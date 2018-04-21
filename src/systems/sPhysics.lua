local Concord = require("lib.concord")
local HC      = require("lib.hc")
local Vector  = require("lib.vector")

local C = require("src.components")

local Physics = Concord.system({C.transform, C.body}, {C.transform, C.collider, "colliding"})

function Physics:init()
   self.world = HC.new(100)
end

function Physics:entityAddedTo(e, pool)
   if pool.name == "colliding" then
      local transform = e:get(C.transform)
      local collider  = e:get(C.collider)

      collider.body = self.world:circle(transform.position.x, transform.position.y, collider.size)
      collider.body.parent = e
   end
end

function Physics:entityRemovedFrom(e, pool)
   if pool.name == "colliding" then
      local collider = e:get(C.collider)

      self.world:remove(collider.body)
   end
end

function Physics:update(dt)
   dt = dt * DT_MULTIPLIER

   local e
   for i = 1, self.pool.size do
      e = self.pool:get(i)

      local transform = e:get(C.transform)
      local body      = e:get(C.body)
      local collider  = e:get(C.collider)

      local friction = body.velocity:clone()
      friction:mul(-1)
      friction:normalizeInplace()
      friction:mul(body.friciton)
      friction:trimInplace(body.velocity:len())

      local aFriction = -body.aVelocity * body.aFriction
      if aFriction > 0 then aFriction = math.max(0, aFriction) end
      if aFriction < 0 then aFriction = math.min(0, aFriction) end

      body.velocity:add(friction * dt)
      body.aVelocity = body.aVelocity + (aFriction * dt)
      
      transform.position:add(body.velocity * dt)
      transform.rotation = transform.rotation + body.aVelocity * dt

      if collider then
         collider.body:moveTo(transform.position.x, transform.position.y)

         local collisions = self.world:collisions(collider.body)
         for shape, delta in pairs(collisions) do
            --transform.position:add(delta.x, delta.y)
            --body.velocity = body.velocity:mirrorOn(Vector(-delta.y, -delta.x))
            --collider.body:move(delta.x, delta.y)
            collider.response(e, shape.parent)
         end
      end
   end
end

function Physics:debugDraw()
   love.graphics.push("all")

   love.graphics.setColor(1, 0, 0)

   local e
   for i = 1, self.colliding.size do
      e = self.colliding:get(i)

      local collider = e:get(C.collider)
      collider.body:draw()
   end

   love.graphics.pop()
end

return Physics