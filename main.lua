love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(5/255, 14/255, 25/255)

DT_MULTIPLIER = 0.5

local Concord = require("lib.concord").init({
   useEvents = true,
})
local Vector = require("lib.vector")

local Game = Concord.instance()
Concord.addInstance(Game)

local C = require("src.components")
local S = require("src.systems")

local Shapes = require("src.objects.shapes")


local globalFlux = S.globalFlux()
local gameFlux   = S.gameFlux()

local shapeRenderer = S.shapeRenderer()
local physics       = S.physics()
local input         = S.input()
local effects       = S.effects(globalFlux)
local camera        = S.camera()

Game:addSystem(globalFlux, "update")
Game:addSystem(gameFlux, "update")

Game:addSystem(input, "update")
Game:addSystem(physics, "update")
Game:addSystem(camera, "update")

Game:addSystem(effects, "draw", "attach")
Game:addSystem(camera, "draw", "attach")
Game:addSystem(shapeRenderer, "draw")
Game:addSystem(physics, "draw", "debugDraw", false)
Game:addSystem(camera, "draw", "detach")
Game:addSystem(effects, "draw", "detach")

local player = Concord.entity()
:give(C.transform, Vector(100, 100), 0, 1)
:give(C.body, Vector(100, 0), 0.5, 500, 6)
:give(C.controls)
:give(C.collider)
:give(C.shape, Shapes.ship_1)

Game:addEntity(player)

camera.target = player

for i = 1, 10 do
   local a = Concord.entity()
   :give(C.transform, Vector(100 + i * 80, -400), 0, 1)
   :give(C.body, Vector(0, 300), love.math.random(), 50, 0)
   :give(C.collider)
   :give(C.shape, Shapes.node)

   Game:addEntity(a)
end