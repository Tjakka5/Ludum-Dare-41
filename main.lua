love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(5/255, 14/255, 25/255)
love.keyboard.setKeyRepeat(true)

DT_MULTIPLIER = 0.5

local Concord = require("lib.concord").init({
   useEvents = true,
})
local Vector = require("lib.vector")

local Game = Concord.instance()
Concord.addInstance(Game)

local C = require("src.components")
local S = require("src.systems")
local E = require("src.entities")

local Shapes = require("src.objects.shapes")
local collResponse = require("src.objects.collResponse")


local globalFlux = S.globalFlux()
local gameFlux   = S.gameFlux()

local shapeRenderer = S.shapeRenderer()
local physics       = S.physics()
local input         = S.input()
local effects       = S.effects(globalFlux)
local camera        = S.camera()
--local terminal      = S.terminal(effects)

Game:addSystem(globalFlux, "update")
Game:addSystem(gameFlux, "update")

Game:addSystem(input, "update")
Game:addSystem(physics, "update")
Game:addSystem(camera, "update")

--Game:addSystem(terminal, "update")
--Game:addSystem(terminal, "textinput")
--Game:addSystem(terminal, "keypressed")

Game:addSystem(effects, "draw", "attach")
Game:addSystem(camera, "draw", "attach")
Game:addSystem(shapeRenderer, "draw")
Game:addSystem(physics, "draw", "debugDraw", true)
Game:addSystem(camera, "draw", "detach")
--Game:addSystem(terminal, "draw")
Game:addSystem(effects, "draw", "detach")

local player = E.player(100, 100)
Game:addEntity(player)

camera.target = player

for i = 1, 10 do
   local enemy = E.enemy(100 + i * 30, 200)
   Game:addEntity(enemy)
end