local PATH = (...):gsub('%.init$', '')

return {
   player = require(PATH..".player"),
   enemy  = require(PATH..".enemy"),
}