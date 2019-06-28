require 'logging'
require 'helper'

ui = {}
local resources = {}
MESSAGE_CLICK, MESSAGE_OVER = 0, 1
local BSTATE_DEFAULT, BSTATE_OVER, BSTATE_CLICK = 1, 2, 3

function ui.MouseOver(button)
	local mx, my = love.mouse.getPosition()
	if  mx > button.x and mx < button.x + button.w and my > button.y and my < button.y + button.h then
		return true
	end
	return false
end

function ui.ButtonImages(default, over, click)
	if not default then 
		log("error No default image for buttons setup\n")
		return
	end
	if not over then
		log("error No mouse-over image for buttons setup\n")
		return
	end
	if not click then
		log("error No click image for buttons setup\n")
		return
	end
	index = #resources + 1
	resources[index] = {}
	resources[index][BSTATE_DEFAULT] = assert(love.graphics.newImage(default))
	resources[index][BSTATE_OVER] = assert(love.graphics.newImage(over))
	resources[index][BSTATE_CLICK] = assert(love.graphics.newImage(click))
	return resources[index]
end

function ui.CreateButton(_ui, x, y, w, h, id, text, resource)
	index = #_ui.buttons + 1
	_ui.buttons[index] = {}
	_ui.buttons[index].x = x
	_ui.buttons[index].y = y
	_ui.buttons[index].w = w
	_ui.buttons[index].h = h
	_ui.buttons[index].scalex = w / resource[BSTATE_DEFAULT]:getWidth()
	_ui.buttons[index].scaley = h / resource[BSTATE_DEFAULT]:getHeight()
	_ui.buttons[index].id = id
	_ui.buttons[index].text = text
	_ui.buttons[index].resource = resource --nadeus chto reference a ne vse copyd
	_ui.buttons[index].current = BSTATE_DEFAULT
end

function ui.DispatchMessage(_ui, _type, msg)
	for _,s in ipairs(_ui.subscribers) do
		s(_type, msg)
	end
end

function ui.subscribe(_ui, func)
	index = #_ui.subscribers + 1
	--subscribers[index] = {}
	_ui.subscribers[index] = func
end

function ui.DestroyResource(param)
	param = nil
	resources = CleanNils(resources)
	collectgarbage('collect')
end

function ui.create()
	local new = {}
	new.buttons = {}
	new.subscribers = {}
	return new
end

function ui.destroy(param)
	param.buttons = nil
	param.subcribers = nil
	param = nil
	collectgarbage('collect')
end

function ui.update(_ui, dt)
	local down = love.mouse.isDown(1)
	for _,b in ipairs(_ui.buttons) do
		if (b.current == BSTATE_DEFAULT) then
			if (ui.MouseOver(b)) then
				b.current = BSTATE_OVER
				ui.DispatchMessage(_ui, MESSAGE_OVER, b.id)
			end
		elseif (b.current == BSTATE_OVER) then
			if (not ui.MouseOver(b)) then
				b.current = BSTATE_DEFAULT
			else
				if (down) then
					b.current = BSTATE_CLICK
				end
			end
		elseif (b.current == BSTATE_CLICK) then
			if (not ui.MouseOver(b)) then
				b.current = BSTATE_DEFAULT
			elseif (not down) then
				ui.DispatchMessage(_ui, MESSAGE_CLICK, b.id)
				b.current = BSTATE_OVER
			end
		end
	end
end

function ui.draw(_ui)
	love.graphics.setColor(1,1,1)
	for _,b in ipairs(_ui.buttons) do
		love.graphics.draw(b.resource[b.current], b.x, b.y, 0, b.scalex, b.scaley)
		love.graphics.setColor(0,0,0)
		love.graphics.printf(b.text, b.x, b.y + b.h/2, b.w, "center")
		love.graphics.setColor(1,1,1)
	end
end