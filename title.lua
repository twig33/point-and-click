require "system"
require "gameState"

title={}
title.loaded = false
buttons = {}
maintitle = nil
message = ""

function title.receive(_type, msg)
	log("type of message received " .. tostring(_type) .. "\n")
	log("message: " .. tostring(msg) .. "\n")
	if (_type == MESSAGE_CLICK) then
		if (msg == 11) then 
			changeGameState(GAMESTATE_GAME, true, GAME_NEWGAME)
		end
	elseif (_type == MESSAGE_OVER) then
		if (msg == 11) then
			message = "Start a new game - erases old save file"
		elseif (msg == 12) then
			message = "Continue from where you left off"
		end
	end
end

function title.load()
title.loaded = true
maintitle = love.graphics.newImage('img/titulo.png')
--buttons[3] = {150, WINDOW_HEIGHT - 50, 360, 72, ""}; bottomTextIndex = 3; --bottom text

if (ui.loaded ~= true) then
	ui.load()
end
resource = ui.ButtonImages('img/default.png','img/over.png','img/click.png')
ui.CreateButton(400,300,360,72,11,"New game",resource)
ui.CreateButton(400,400,360,72,12,"Continue",resource) 
ui.subscribe(title.receive)
end

function title.unload()
title.loaded = false
maintitle = nil
buttons = nil
ui.unload()
end

function title.update(dt)
	ui.update(dt)
	return true
end

function title.draw()
	love.graphics.setColor(1, 1, 1)
		love.graphics.draw(maintitle)
	love.graphics.setColor(0, 0, 0.1)
		love.graphics.printf("CAVERN", 0, 140 , 400, "center")
	love.graphics.setColor(1,0,0)
		love.graphics.printf(message, 160, 430, 400, "left")
	ui.draw()
end