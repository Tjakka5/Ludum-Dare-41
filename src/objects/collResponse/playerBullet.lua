local C = require("src.components")

return function(e, o)
   local eDamager = e:get(C.damager)

   if eDamager then
      if not o:has(C.player) then
         local oHealth = o:get(C.health)

         oHealth.health = oHealth.health - eDamager.damage
         if oHealth.health <= 0 then
            o:destroy()
         end
      end
   end
end