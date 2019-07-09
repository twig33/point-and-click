require 'logging'
require 'ui'

my_ui = nil
bres = nil
bg = nil
canvasdata = nil
canvasimg = nil
imgpath = ""
green = 1
local dir = love.filesystem.getSource()

function FilenameFromPath(s)
	local slash = "\\"
	local slasht = "/"
	assert(type(s) == "string", "Path not string")
	for i=#s,1,-1 do
		local c = s:sub(i,i)
		if (c == slash or c == slasht) then
			return s:sub(i+1, #s)
		end
	end
end

function receive(_type, id)
	if (_type == MESSAGE_CLICK) then
		if (id == 11) then
			if (canvasdata ~= nil) then
				local name = FilenameFromPath(imgpath)
				local savename = name:sub(1, #name - 4) .. "col" .. ".png"
			--	file = assert(io.open(dir .. '/' .. "key2.png", "w"))
			--	file:write("a")
				log(savename .. "\n")
				log(dir .. "/output/" .. savename .. "\n")
				filedata = canvasdata:encode("png")
				filestring = filedata:getString()
				--TableDelete(filestring, 5)
				--filestring = filestring:sub(1, 4) .. filestring:sub(6, #filestring)
				--log("\n" .. filestring)
				--log(tostring(string.byte(filestring:sub(6,6))) .. "\n")
				local filee = io.open(dir .. "/output/" .. savename, "wb")
				filee:write(filestring)
				--love.filesystem.setSymlinksEnabled( enable )
				canvasdata:encode('png', savename) --love2d sohranyet v save directory
			--	assert(os.rename(dir .. "/" .. savename, 'output/' .. savename), "Couldn't move")
			end
		end
	end
end

function love.filedropped(file)
	imgpath = file:getFilename()
	log("File dropped " .. imgpath .. "\n")
	local data = file:read()
	bg = love.graphics.newImage(love.image.newImageData(love.filesystem.newFileData(data, 'img', 'file')))
	canvasdata = love.image.newImageData(bg:getWidth(), bg:getHeight())
	canvasimg = love.graphics.newImage(canvasdata)
	success = love.window.setMode(bg:getWidth(), bg:getHeight() + 50)
	my_ui:MoveButton(11, 0, bg:getHeight())
	my_ui:ResizeButton(11, bg:getWidth(), 50)
end
function love.mousepressed( x, y, button, istouch, presses )
	if (bg ~= nil and button == 1 and green > 0 and x < bg:getWidth() and y < bg:getHeight()) then
		canvasdata:setPixel(x, y, 0, green, 0, 255)
		canvasimg:replacePixels(canvasdata)
		green = green - 0.005
		if (green <= 0) then
			log("Vertices limit reached\n")
		end
	end
end
function love.load()
	log("Init\n")
	success = love.window.setMode(400, 50)
	my_ui = ui:create()
	bres = ui.ButtonImages('img/default.png', 'img/over.png', 'img/click.png')
	my_ui:CreateButton(0, 0, 400, 50, 11, "Save", bres)
	my_ui:subscribe(receive)
end
function love.draw()
	if(bg and canvasimg) then
		love.graphics.setColor(1, 1, 1, 0.75)
		love.graphics.draw(bg, 0, 0)
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(canvasimg, 0, 0)
	end
	love.graphics.setColor(1, 1, 1, 1)
	my_ui:draw()
end
 
function love.update( dt )
	my_ui:update(dt)
end