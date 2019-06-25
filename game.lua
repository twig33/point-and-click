require "animating"
require "rooms/intro"
require "gameState"

game={}
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
end
function game.unload()
	game.loaded = false
	adachi.unload()
end
function game.draw()
	love.graphics.setColor(1, 1, 1)
	Room[gameState.room].draw()
	adachi.draw()
	return
end
function game.update(dt)
	adachi.update(dt)
end