function getGlobals()
  require("source/animating")
  
  require ("source/debug/dbg")
  require("source/debug/helper")
  require("source/debug/logging")
  

  require("source/global/game")
  require("source/global/gameState")
  require("source/global/collision")
  require("source/global/message")
  require("source/global/objects")
  require("source/global/pause")
  require("source/global/PointWithinShape")
  gameStateInit()

  HC = require("source/lib/hardoncollider")
  updateGameplay = require("source/update")
  player = require("source/player")

  require("source/maps/intro")
  require("source/maps/map")
  require("source/maps/office")
  require("source/maps/street")
  require("source/maps/title")

  require("source/ui/ui")

end