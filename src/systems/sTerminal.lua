local Concord = require("lib.concord")

local C = require("src.components")

local Terminal = Concord.system({C.none})

function Terminal:init(effects)
   self.font   = love.graphics.newFont("assets/LCD_Solid.ttf", 30)
   self.buffer = ""

   self.env = {
      game = {
         start = function()
            print("We start game")
         end,
         registerKeys = function(up, down, left, right, shoot, openTerminal)
            print("We register keys")
         end, 
      },
      player = {
         blink = function(x, y)
            print("We blink")
         end
      },
      print = function(msg)
         self.buffer = msg
      end,
   }
   self.docs = {
      {name = "game.start", args = {}},
      {name = "game.registerKeys", {"up", "down", "left", "right", "shoot", "openTerminal"}},
      
      {name = "player.blink", args = {"x", "y"}},
      
      {name = "print", args = {"msg"}},
   }

   self.options          = {}
   self.characterOptions = {}
   self.selectedOption   = 1

   self.effects = effects

   self:getOptions()
end

function Terminal:getCharacterOptions()
   local options = {}
end

function Terminal:getOptions()
   self.options = {}

   for _, option in ipairs(self.docs) do
      local sub = option.name:sub(1, #self.buffer)
      if sub == self.buffer then
         self.options[#self.options+1] = option
      end
   end
end

function Terminal:start()
   self.buffer = ""
   self.effects:toTerminal()
end

function Terminal:stop()
   self.buffer = ""
   self.effects:toNormal()
end

function Terminal:update(dt)

end

function Terminal:textinput(t)
   self.buffer = self.buffer..t
   self.selectedOption = 1

   self:getOptions()
end

function Terminal:keypressed(key)
   if key == "backspace" then
      if #self.buffer > 0 then
         self.buffer = self.buffer:sub(1, #self.buffer - 1)
         self.selectedOption = 1
      end
   end

   if key == "return" then
      local f, loadErr = loadstring(self.buffer)
      
      if loadErr then
         print(loadErr)
      else
         setfenv(f, self.env)
         local succ, runErr = pcall(f)
         
         if not succ then
            print(runErr)
         end
      end
   end

   if key == "return" or key == "esc" then

   end
end

function Terminal:draw()
   love.graphics.push("all")
   
   local x, y = love.graphics.getWidth() / 6, love.graphics.getHeight() / 6
   local w, h = love.graphics.getWidth() - x*2, love.graphics.getHeight() - y*2

   love.graphics.setColor(0, 0, 0, 0.75)
   love.graphics.rectangle("fill", x, y, w, h, 5)

   local predict = ""

   if self.options[self.selectedOption] then
      predict = self.options[self.selectedOption].name
   end

   local str = {{1, 1, 1, 1}, self.buffer, {0.35, 0.35, 0.35, 1}, predict}

   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.setFont(self.font)
   love.graphics.printf(str, x, y + h /4, w, "center")

   love.graphics.pop()
end

return Terminal