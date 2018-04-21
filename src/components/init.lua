local PATH = (...):gsub('%.init$', '')

return {
   transform = require(PATH..".cTransform"),
   shape     = require(PATH..".cShape"),
   color     = require(PATH..".cColor"),
   controls  = require(PATH..".cControls"),
   body      = require(PATH..".cBody"),

   none = require(PATH..".cNone"),
}