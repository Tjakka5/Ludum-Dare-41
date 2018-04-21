local Concord   = require("lib.concord")
local Moonshine = require("lib.moonshine")

local C = require("src.components")

local Effects = Concord.system({C.none})

function Effects:init()
   chain = Moonshine(Moonshine.effects.glow).chain(Moonshine.effects.chromasep)
   chain.parameters = {
      glow = {
         min_luma = 0.7,
         strength = 5,
      },
      chromasep = {
         angle  = 0,
         radius = 3,
      },
   }
end

function Effects:attach()
   chain:attach()
end

function Effects:detach()
   chain:detach()
end


return Effects