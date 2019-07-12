require "source.startup.system"
require "source.global.gameState"
title={}
title.ui = {}
title.resources = {}
title.loaded = false
buttons = {}
maintitle = nil
message = ""

function title.receive(_type, msg)
	log("type of message received " .. tostring(_type) .. "\n")
	log("message: " .. tostring(msg) .. "\n")
	if (_type == MESSAGE_CLICK) then
		if (msg == 11) then 
			ChangeGameState(GAMESTATE_GAME, true, GAME_NEWGAME)
			title.unload()
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
	title.ui = ui:create()
	title.ui:CreateButton(400,300,360,72,11,"New game",SharedResources.mainButtons)
	title.ui:CreateButton(400,400,360,72,12,"Continue",SharedResources.mainButtons) 
	title.ui:subscribe(title.receive)
end

function title.unload()
	title.loaded = false
	maintitle = nil
	buttons = nil
	--ui.DestroyResource(title.resources)
	title.ui:destroy()
	collectgarbage('collect')
end

function title.update(dt)
	title.ui:update(dt)
	return true
end

function title.draw()
	love.graphics.setColor(1, 1, 1)
		love.graphics.draw(maintitle)
	love.graphics.setColor(0, 0, 0.1)
		love.graphics.printf("CAVERN", 0, 140 , 400, "center")
	love.graphics.setColor(1,0,0)
		love.graphics.printf(message, 160, 430, 400, "left")
	title.ui:draw()
	love.graphics.setColor(0,0,0)
	--love.graphics.polygon('fill', title.objects[1].polygon:unpack())
end