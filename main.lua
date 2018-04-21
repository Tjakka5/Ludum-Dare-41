local Concord = require("lib.concord").init({
   useEvents = true,
})
local Vector = require("lib.vector")

local Game = Concord.instance()
Concord.addInstance(Game)

local C = require("src.components")
local S = require("src.systems")

local shapeRenderer = S.shapeRenderer()
local physics       = S.physics()
local input         = S.input()
local effects       = S.effects()

Game:addSystem(effects, "draw", "attach")
Game:addSystem(shapeRenderer, "draw")
Game:addSystem(effects, "draw", "detach")
Game:addSystem(input, "update")
Game:addSystem(physics, "update")

local player = Concord.entity()
:give(C.transform, Vector(100, 100), 0, 5)
:give(C.body, Vector(100, 0), 0.5, 200, 5)
:give(C.controls)
:give(C.shape, {
   8, 0,
   9, 1,
   9, 2,
   11, 2,
   12, 3,
   13, 4,
   13, 5,
   14, 6,
   14, 9,
   13, 9,
   12, 9,
   11, 9,
   9, 9,
   8, 8,

   6, 8,
   5, 9,
   3, 9,
   2, 9,
   1, 9,
   0, 9,
   0, 6,
   1, 5,
   1, 4,
   2, 3,
   3, 2,
   5, 2,
   5, 1,
   6, 0,
})

local points = player:get(C.shape).points
for x = 1, #points, 2 do
   points[x] = points[x] - 7
end

for y = 2, #points, 2 do
   points[y] = points[y] - 5
end

Game:addEntity(player)
