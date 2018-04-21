local PATH = (...):gsub('%.init$', '')

return {
   shapeRenderer = require(PATH..".sShapeRenderer"),
   physics       = require(PATH..".sPhysics"),
   input         = require(PATH..".sInput"),
   effects       = require(PATH..".sEffects"),
   camera        = require(PATH..".sCamera"),

   globalFlux = require(PATH..".sGlobalFlux"),
   gameFlux   = require(PATH..".sGameFlux"),
}