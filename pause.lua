require 'ui'
require 'game'

pause = {}
pause.loaded = false


function pause.receive(_type, msg)
	if (_type == MESSAGE_CLICK) then
		if (msg == 9) then
			ChangeGameState(GAMESTATE_GAME, true, GAME_NEWGAME)
		elseif (msg == 10) then
			ChangeGameState(GAMESTATE_MAINMENU, true)
		end
	end
end

function pause.load()
	pause.ui = {}
	pause.blur = {}
	pause.blur.scalex = 0
	pause.blur.scaley = 0
	pause.loaded = true
	pause.ui = ui.create()
	pause.ui:subscribe(pause.receive)
	pause.ui:CreateButton(WINDOW_WIDTH / 2 - 100,200,200,72,9,"Resume",SharedResources.mainButtons)
	pause.ui:CreateButton(WINDOW_WIDTH / 2 - 100, 280, 200, 72, 10, "Main Menu", SharedResources.mainButtons)
	pause.blur.image = love.graphics.newImage('img/blur.png')
	pause.blur.scalex = WINDOW_WIDTH / pause.blur.image:getWidth()
	pause.blur.scaley = WINDOW_HEIGHT / pause.blur.image:getHeight()
end
function pause.unload()
	pause.loaded = false
	pause.ui:destroy()
	pause.blur = nil
	collectgarbage('collect')
end
function pause.update(dt)
	ui.update(pause.ui, dt)
end
function pause.draw()
	game.draw()
	love.graphics.draw(pause.blur.image, 0, 0, 0, pause.blur.scalex, pause.blur.scaley)
	pause.ui:draw()
end