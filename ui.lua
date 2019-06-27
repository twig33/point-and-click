require 'logging'

ui = {}

MESSAGE_CLICK, MESSAGE_OVER = 0, 1
local resources = {}
local buttons = {}
local subscribers = {}
ui.loaded = false

function ui.MouseOver(button)
	local mx, my = love.mouse.getPosition()
	log(tostring(button.x) .. "\n")
	log(tostring(button.y) .. "\n")
	log(tostring(button.w) .. "\n")
	log(tostring(button.h) .. "\n")
	log(tostring(mx) .. "\n")
	log(tostring(my) .. "\n\n")
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
	resources[index].default = assert(love.graphics.newImage(default))
	resources[index].over = assert(love.graphics.newImage(over))
	resources[index].click = assert(love.graphics.newImage(click))
	return index
end

function ui.CreateButton(x, y, w, h, id, text, resIndex)
	index = #buttons + 1
	buttons[index] = {}
	buttons[index].x = x
	buttons[index].y = y
	buttons[index].w = w
	buttons[index].h = h
	buttons[index].scalex = w / resources[resIndex].default:getWidth()
	buttons[index].scaley = h / resources[resIndex].default:getHeight()
	buttons[index].id = id
	buttons[index].text = text
	buttons[index].resIndex = resIndex
	buttons[index].current = resources[resIndex].default
end

function ui.DispatchMessage(_type, msg)
	for _,s in ipairs(subscribers) do
		s(_type, msg)
	end
end

function ui.subscribe(func)
	index = #subscribers + 1
	--subscribers[index] = {}
	subscribers[index] = func
end

function ui.load()
	ui.loaded = true
	resources = {}
	buttons = {}
end

function ui.unload()
	ui.loaded = false
	resources = nil
	buttons = nil
end

function ui.update(dt)
	local down = love.mouse.isDown(1)
	for _,b in ipairs(buttons) do
		if (ui.MouseOver(b)) then
			ui.DispatchMessage(MESSAGE_OVER, b.id)
			if (down) then
				b.current = resources[b.resIndex].click
			else
				if (b.current == resources[b.resIndex].click) then
					b.current = resources[b.resIndex].over
					ui.DispatchMessage(MESSAGE_CLICK, b.id)
					return
				else
					b.current = resources[b.resIndex].over
				end
			end
		else
			b.current = resources[b.resIndex].default
		end
	end
end

function ui.draw()
	love.graphics.setColor(1,1,1)
	for _,b in ipairs(buttons) do
		love.graphics.draw(b.current, b.x, b.y, 0, b.scalex, b.scaley)
		love.graphics.setColor(0,0,0)
		love.graphics.printf(b.text, b.x, b.y + b.h/2, b.w, "center")
		love.graphics.setColor(1,1,1)
	end
end