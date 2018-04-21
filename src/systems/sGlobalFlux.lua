local Concord = require("lib.concord")
local Flux    = require("lib.flux")

local C = require("src.components")

local GlobalFlux = Concord.system({C.none})

function GlobalFlux:init()
   self.flux = Flux.group()
end

function GlobalFlux:update(dt)
   self.flux:update(dt)
end

return GlobalFlux