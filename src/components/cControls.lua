local Concord = require("lib.concord")

local Controls = Concord.component(function(e, up, down, left, right, shoot, terminal)
   e.up       = up       or "w"
   e.down     = down     or "s"
   e.left     = left     or "a"
   e.right    = right    or "d"
   e.shoot    = shoot    or "space"
   e.terminal = terminal or "q"
end)

return Controls