local Concord = require("lib.concord")
local Flux    = require("lib.flux")

local C = require("src.components")

local GameFlux = Concord.system({C.none})

function GameFlux:init()
   self.flux = Flux.group()
end

function GameFlux:update(dt)
   dt = dt * DT_MULTIPLIER
   
   self.flux:update(dt)
end

return GameFlux