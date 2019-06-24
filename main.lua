HC = require "lib.hardoncollider"
require 'animating'
require 'maps.office'
require 'title'
require 'gameState'
 local updateGameplay = require("update")
local player = require 'player'
gameState.room = "MainMenu"
function love.load()
	adachi.load()
	title.load()
	gameStateInit()
	office.load()
	bg = love.graphics.newImage('img/oz_screen6.jpg')
end

function love.draw()

love.graphics.setColor(1, 1, 1)
	love.graphics.draw(bg)
        player.draw()
	adachi.draw()
	title.draw()
	office.draw()
end
 
function love.update( dt )

        player.update( dt )
	adachi.update( dt )
end

function love.mousepressed( x, y, button, istouch )
 if button == 1 and gameState.room == "MainMenu" then
buttons:click()
end
end