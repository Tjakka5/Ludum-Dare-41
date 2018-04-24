local Concord = require("lib.concord")

local C = require("src.components")

local Terminal = Concord.system({C.none})

local function sort(a, b)
   return a[1] < b[1]
end

function Terminal:init(effects)
   self.font   = love.graphics.newFont("assets/LCD_Solid.ttf", 30)
   self.buffer = ""

   self.environment = {
      -- name, VALUE, fetch
      -- name, METHOD, args, apply
      -- name, AUTOCOMPLETE

      {"player.", "autocomplete"},
      {"player.blink", "method", {{"x", "number"}, {"y", "number"}}, function(x, y) print("Blink!") end},
      {"player.boost", "method", {{"x", "number"}, {"y", "number"}}, function(x, y) print("Boost!") end},
      {"player.xPos", "number", function() end},

      {"game.", "autocomplete"},
      {"game.start", "method", {}, function() print("Start!") end},

      {"print", "method", {{"msg", "string"}}, function(msg) print(msg) end},
      --{"for", "method", {{"i", "number"}}, function(i) print("do for") end},
   }

   table.sort(self.environment, sort)

   self.current  = {}
   self.expected = "method"
   self.currArg  = 0

   self.options = {}
   self:getOptions()

   self.selected = 1

   self.effects = effects
end

function Terminal:isLegit(cmd)
   for _, thing in ipairs(self.environment) do
      if thing[2] == self.expected or thing[2] == "autocomplete" then
         local name = thing[1]

         local sub = name:sub(1, #cmd)

         if sub == cmd then
            return true
         end
      end
   end
end

function Terminal:getOptions()
   self.options = {}

   for _, thing in ipairs(self.environment) do
      print(thing[2], self.expected)
      if thing[2] == self.expected or thing[2] == "autocomplete" then
         local name = thing[1]

         if #self.buffer ~= #name then
            local sub = name:sub(1, #self.buffer)

            if sub == self.buffer then
               self.options[#self.options + 1] = thing 
            end
         end
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
   local nBuffer = self.buffer..t

   if self:isLegit(nBuffer) then
      self.buffer = nBuffer
      self:getOptions()
      self.selected = 1
   end
end

function Terminal:keypressed(key)
   if key == "backspace" then
      if #self.buffer > 0 then
         self.buffer = self.buffer:sub(1, #self.buffer - 1)

         self:getOptions()
         self.selected = 1
      end
   elseif key == "up" then
      if #self.options > 0 then
         self.selected = self.selected - 1
         if self.selected < 1 then
            self.selected = #self.options
         end
      end
   elseif key == "down" then
      if #self.options > 0 then
         self.selected = self.selected + 1
         if self.selected > #self.options then
            self.selected = 1
         end
      end
   elseif key == "tab" then
      if #self.options > 0 then
         self.buffer = self.options[self.selected][1]
         self:getOptions()
         self.selected = 1
      end
   elseif key == "return" then
      for _, thing in ipairs(self.environment) do
         local name = thing[1]
         if self.buffer == name then
            if thing[2] ~= "autocomplete" then
               self.current[#self.current + 1] = thing
               self.buffer = ""
               
               if self.expected == "method" then
                  self.expected = thing[3][1][2] -- what the hell
      

                  self:getOptions()
                  self.selected = 1
               else
                  
               end
            end
            
            break
         end
      end
   end
end

function Terminal:draw()
   love.graphics.push("all")
   
   local x, y = love.graphics.getWidth() / 6, love.graphics.getHeight() / 6
   local w, h = love.graphics.getWidth() - x*2, love.graphics.getHeight() - y*2

   love.graphics.setColor(0, 0, 0, 0.75)
   love.graphics.rectangle("fill", x, y, w, h, 5)

   local pre  = ""
   local args = ""

   for i, thing in ipairs(self.current) do
      pre = pre..thing[1].." "

      if i == #self.current then
         -- Do args
      else
         --pre = pre.." "
      end
   end

   local predict = ""
   if #self.options > 0 then
      local thing = self.options[self.selected]
      local name  = thing[1]
      predict = name:sub(#self.buffer + 1, #name)
   end

   local str = {{1, 1, 1, 1}, pre, {1, 1, 1, 1}, self.buffer, {0.35, 0.35, 0.35, 1}, predict}

   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.setFont(self.font)
   love.graphics.printf(str, x, y + h /4, w, "center")

   love.graphics.pop()
end

return Terminal