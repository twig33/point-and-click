require 'ui'
require 'game'

pause = {}
pause.loaded = false
pause.ui = {}
pause.blur = {}
pause.blurscalex = 0
pause.blurscaley = 0

function pause.receive(_type, msg)
	if (_type == MESSAGE_CLICK) then
		if (msg == 9) then
			ChangeGameState(GAMESTATE_GAME, true, GAME_NEWGAME)
		end
	end
end

function pause.load()
	pause.loaded = true
	pause.ui = ui.create()
	ui.subscribe(pause.ui, pause.receive)
	ui.CreateButton(pause.ui, WINDOW_WIDTH / 2 - 100,300,200,72,9,"Resume",SharedResources.mainButtons)
	pause.blur = love.graphics.newImage('img/blur.png')
	pause.blurscalex = WINDOW_WIDTH / pause.blur:getWidth()
	pause.blurscaley = WINDOW_HEIGHT / pause.blur:getHeight()
end
function pause.unload()
	pause.loaded = false
	pause.ui = nil
	pause.blur = nil
	collectgarbage('collect')
end
function pause.update(dt)
	ui.update(pause.ui, dt)
end
function pause.draw()
	game.draw()
	love.graphics.draw(pause.blur, 0, 0, 0, pause.blurscalex, pause.blurscaley)
	ui.draw(pause.ui)
end