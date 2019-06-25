
gameState = {}
gameState.player = {}
gameState.pickups = {}

GAMESTATE_NULL, GAMESTATE_MAINMENU, GAMESTATE_GAME, GAMESTATE_CREDITS = 0, 1, 2, 3 --"""""enum"""""
ROOM_NULL, ROOM_INTRO = 0, 1
GAME_NEWGAME, GAME_CONTINUE = 1, 2

function gameStateInit()

  -- Number of times the game has been saved.
  -- Used to prevent certain save blocks from spawning
  gameState.saveCount = 0

  -- State stores if update functions should occur
  gameState.state = GAMESTATE_NULL
  gameState.room = ROOM_NULL
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

function changeGameState(staet, unload, param)
	param = param or nil
	unload = unload or true
	if (gameState.state ~= GAMESTATE_NULL and unload == true) then
		GameState[gameState.state].unload()
	end
	gameState.state = staet
	if (gameState.state ~= GAMESTATE_NULL and GameState[gameState.state].loaded == false) then
		GameState[gameState.state].load(param)
	end
end