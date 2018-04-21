local Concord   = require("lib.concord")
local Moonshine = require("lib.moonshine")

local C = require("src.components")

local Effects = Concord.system({C.none})

function Effects:init(flux)
   self.chain = Moonshine(Moonshine.effects.vignette)
   .chain(Moonshine.effects.chromasep)
   .chain(Moonshine.effects.glow)
   .chain(Moonshine.effects.scanlines)
   .chain(Moonshine.effects.crt)

   self.chain.parameters = {
      glow = {
         min_luma = 0.2,
         strength = 3,
      },
      chromasep = {
         angle  = 0,
         radius = 3,
      },
      vignette = {
         radius   = 1.8,
         softness = 1,
         opacity  = 0.8,
         color    = {0, 0, 0},
      },
      scanlines = {
         width     = 2,
         frequency = love.graphics.getHeight(),
         phase     = 0,
         thickness = 1,
         opacity   = 0.4,
         color     = {0, 0, 0},
      },
      crt = {
         distortionFactor = {1, 1},
         x                = 1,
         y                = 1,
         scaleFactor      = {1, 1},
         feather          = 0,
      },
   }

   self.paramBuffer = {
      opacity           = 0.4,
      distortionFactorX = 1,
      distortionFactorY = 1,
      x                 = 1,
      y                 = 1,
      feather           = 0,
   }

   self.flux = flux
end

function Effects:toNormal()
   local t = 0.2

   self.flux.flux:to(self.paramBuffer, t, {
      opacity           = 0.4,
      distortionFactorX = 1,
      distortionFactorY = 1,
      x                 = 1,
      y                 = 1,
      feather           = 0,
   })
end

function Effects:toTerminal()
   local t = 0.2

   self.flux.flux:to(self.paramBuffer, t, {
      opacity           = 1,
      distortionFactorX = 1.2,
      distortionFactorY = 1.3,
      x                 = 1.06,
      y                 = 1.065,
      feather           = 0.02,
   })
end

function Effects:attach()
   self.chain.scanlines.opacity    = self.paramBuffer.opacity
   self.chain.crt.distortionFactor = {self.paramBuffer.distortionFactorX, self.paramBuffer.distortionFactorY}
   self.chain.crt.x                = self.paramBuffer.x
   self.chain.crt.y                = self.paramBuffer.y
   self.chain.crt.feather          = self.paramBuffer.feather

   if love.keyboard.isDown("l") then
      self:toTerminal()
   else
      self:toNormal()     
   end

   self.chain:attach()
end

function Effects:detach()
   self.chain:detach()
end


return Effects