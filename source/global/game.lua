require "source.global.gameState"
require "source.maps.intro"
game={}
game.ui = {}
game.loaded = false
local Room = 
{
	[ROOM_INTRO] = intro
}
function game.changeRoom(param)
	param = param or nil
	if (gameState.room ~= ROOM_NULL) then
		Room[gameState.room].unload()
	end
	gameState.room = param
	if (gameState.room ~= ROOM_NULL) then
		Room[gameState.room].load()
	end
end
function game.load(param)
	game.loaded = true
	if (param == GAME_NEWGAME) then
		game.changeRoom(ROOM_INTRO)
	end
	adachi.load()
	game.ui = ui:create()
	game.ui:CreateButton(100, 100, 50, 50, 22, "adachi kill", SharedResources.mainButtons)
end
function game.unload()
	game.loaded = false
	adachi.unload()
end
function game.draw()
	love.graphics.setColor(1, 1, 1)
	Room[gameState.room].draw()
	game.ui:draw()
	adachi.draw()
	return
end
function game.update(dt)
	game.ui:update(dt)
	adachi.update(dt)
	if (love.keyboard.isDown("escape")) then
		ChangeGameState(GAMESTATE_PAUSE, false)
	end
end