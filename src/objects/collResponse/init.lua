local PATH = (...):gsub('%.init$', '')

return {
   playerBullet = require(PATH..".playerBullet")
}