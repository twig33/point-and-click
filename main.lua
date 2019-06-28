HC = require "lib.hardoncollider"
require 'animating'
require 'maps.office'
require 'ui'
require 'logging'
require 'gameState'
require 'dbg'
require 'title'
require 'game'
require 'pause'

GameState = 
{
	[GAMESTATE_MAINMENU] = title,
	[GAMESTATE_GAME] = game,
	[GAMESTATE_PAUSE] = pause,
}
local updateGameplay = require("update")
local player = require 'player'
local TIME = 5
local timer = TIME
SharedResources = {}

--local title = require 'title'
--local game = require 'game'
--local gameState = require 'gameState'


function love.load()
	--adachi.load()
	--title.load()
	log("\n\nInit\n")
--	ui.load()
	SharedResources.mainButtons = ui.ButtonImages('img/default.png','img/over.png','img/click.png')
	gameStateInit()
	gameState.state = GAMESTATE_NULL
	ChangeGameState(GAMESTATE_MAINMENU)
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
	timer = timer - dt
	if (timer <= 0) then 
		log("Memory used: " .. tostring(collectgarbage('count')) .. " KB\n")
		timer = TIME
	end
	GameState[gameState.state].update(dt)
end