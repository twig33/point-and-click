gameState = {}
gameState.player = {}
gameState.pickups = {}

GAMESTATE_NULL, GAMESTATE_MAINMENU, GAMESTATE_GAME = 0, 1, 2 --"""""enum"""""

GameState = 
{
	[GAMESTATE_MAINMENU] = title,
	[GAMESTATE_GAME] = game,
}

function gameStateInit()

  -- Number of times the game has been saved.
  -- Used to prevent certain save blocks from spawning
  gameState.saveCount = 0

  -- State stores if update functions should occur
  gameState.state = GAMESTATE_NULL

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

function changeGameState(param)
	if (gameState.state != GAMESTATE_NULL)
		GameState[gameState.state].finish()
	end
	gameState.state = param
	if (gameState.state != GAMESTATE_NULL)
		GameState[gameState.state].init()
	end
end