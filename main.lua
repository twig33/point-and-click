SharedResources = {}
ClickSubscribers = {}

local TIME = 5
local timer = TIME

function SubscribeToClick(subscriber)
	ClickSubscribers[#ClickSubscribers + 1] = subscriber
end
function love.mousepressed( x, y, button, istouch, presses )
	for _, s in ipairs(ClickSubscribers) do
		s:mousepressed(x, y, button, istouch, presses)
	end
end
function love.load()

	require("source/startup/startup")
  	startup()
		log("\n\nInit\n")
	SharedResources.mainButtons = ui.ButtonImages('img/default.png','img/over.png','img/click.png')
	gameStateInit()
	gameState.state = GAMESTATE_NULL
	ChangeGameState(GAMESTATE_MAINMENU)
	debug.load()
end


function love.draw()
	love.graphics.setColor(1, 1, 1)
	--logfile:write("aaaa")
	GameState[gameState.state].draw()
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