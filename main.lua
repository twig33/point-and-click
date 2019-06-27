HC = require "lib.hardoncollider"
require 'animating'
require 'maps.office'
require 'ui'
require 'title'
require 'game'
require 'logging'
require 'gameState'
require 'dbg'
local updateGameplay = require("update")
local player = require 'player'
GameState = 
{
	[GAMESTATE_MAINMENU] = title,
	[GAMESTATE_GAME] = game,
}
--local title = require 'title'
--local game = require 'game'
--local gameState = require 'gameState'


function love.load()
	--adachi.load()
	--title.load()
	log("\n\nInit\n")
	ui.load()
	gameStateInit()
	gameState.state = GAMESTATE_NULL
	changeGameState(GAMESTATE_MAINMENU)
	--office.load()
	--bg = love.graphics.newImage('img/oz_screen6.jpg')
	debug.load()
end
function love.draw()
	love.graphics.setColor(1, 1, 1)
	--logfile:write("aaaa")
	GameState[gameState.state].draw()

--love.graphics.setColor(1, 1, 1)
--	love.graphics.draw(bg)
--        player.draw()
--	adachi.draw()
--	title.draw()
--	office.draw()
	debug.mouseLocation()
end
 
function love.update( dt )
	GameState[gameState.state].update(dt)
end