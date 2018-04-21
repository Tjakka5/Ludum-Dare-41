local PATH = (...):gsub('%.init$', '')

return {
   ship_1 = require(PATH..".ship_1"),
   ship_2 = require(PATH..".ship_2"),
   node   = require(PATH..".node"),
}