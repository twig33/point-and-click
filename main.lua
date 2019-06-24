HC = require "lib.hardoncollider"
require 'animating'
require 'maps.office'
--require 'io'
require 'title'
require 'gameState'
local updateGameplay = require("update")
local player = require 'player'
--local title = require 'title'
--local game = require 'game'
--local gameState = require 'gameState'
local logfile = assert(io.open("log.txt", "a"))

function love.load()
	--adachi.load()
	--title.load()
	gameStateInit()
	--office.load()
	--bg = love.graphics.newImage('img/oz_screen6.jpg')
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	logfile:write("aaaa")
	GameState[gameState.state].draw()
end
 
function love.update( dt )
	GameState[gameState.state].update(dt)
end

function love.mousepressed( x, y, button, istouch )
 if button == 1 and gameState.state == GAMESTATE_MAINMENU then
buttons:click()
end
end