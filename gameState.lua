gameState = {}
gameState.player = {}
gameState.pickups = {}

function gameStateInit()

  -- Number of times the game has been saved.
  -- Used to prevent certain save blocks from spawning
  gameState.saveCount = 0

  -- State stores if update functions should occur
  gameState.state = 1

  -- Stores the current room
  gameState.room = "MainMenu" 

  -- Player information
  gameState.player.x = 50
  gameState.player.y = 50
  gameState.player.maxHealth = 20
  gameState.player.weapon = 0

  -- Which pickups have been obtained
  gameState.pickups.blaster = false
  gameState.pickups.rocket = false
  gameState.pickups.harpoon = false
  gameState.pickups.aquaPack = false
  gameState.pickups.health1 = false
  gameState.pickups.health2 = false

  -- Changes to false after the tutorial text disappears
  gameState.tutorial = true

end