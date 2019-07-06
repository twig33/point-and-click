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
objectst = require 'objectst'

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
ClickSubscribers = {}

--local title = require 'title'
--local game = require 'game'
--local gameState = require 'gameState'

function SubscribeToClick(func)
	ClickSubscribers[#ClickSubscribers + 1] = func
end
function love.mousepressed( x, y, button, istouch, presses )
	for _, s in ipairs(ClickSubscribers) do
		s(x, y, button, istouch, presses)
	end
end
function love.load()
	--adachi.load()
	--title.load()
	log("\n\nInit\n")
--	ui.load()
	SharedResources.mainButtons = ui.ButtonImages('img/default.png','img/over.png','img/click.png')
	gameStateInit()
	gameState.state = GAMESTATE_NULL
	ChangeGameState(GAMESTATE_MAINMENU)
	--objectstest = objectst(10)
	--log(tostring(objectstest.e) .. "\n")
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