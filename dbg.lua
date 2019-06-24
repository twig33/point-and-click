debugs = {}

function debug.load()
end

function debug.mouseLocation()
	xMouse, yMouse = love.mouse.getPosition( )
	love.graphics.print(xMouse)
	love.graphics.print(yMouse, 0, 10)
end