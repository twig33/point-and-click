Polygon = require 'lib.hardoncollider.polygon'
require 'logging'

objects = {}
objects.__index = objects

--internal functions
function objects:IndexByID(id)
	for i=1,#self,+1 do
		if (self[i].id == id) then
			return i
		end
	end
	log("error No object with id " .. tostring(id) .. "\n")
	return nil
end

function objects:AddObjectResources(index, path, ...)
	if (path) then
		self[index].resources.paths[#(self[index].resources.paths) + 1] = path
		self[index].resources.imgs[#(self[index].resources.imgs) + 1] = love.graphics.newImage(path)
		return self.AddObjectResources(index, ...)
	else
		return #(self[index].resources)
	end
end

function objects.CollisionImage(path)
	local col = love.graphics.newImage(path)
	local w = col:getWidth()
	local h = col:getHeight()
	local imgdata = col:getData()
	local red = {}
	for y=0, h, +1 do
		for x=0, w, +1 do
			local r, g, b, a = imgdata:getPixel(x, y)
			if (r == 1) then
				red[#red + 1] = x
				red[#red + 1] = y
			end
		end
	end
	col = nil
	imgdata = nil
	return unpack(red)
end

--external functions
function objects:UnloadAllResources()
	for _, obj in ipairs(self) do
		obj.resources = nil
	end
	collectgarbage('collect')
end

function objects:LoadAllResources()
	for i=1, #self,+1 do
		self:AddObjectResources(i, unpack(_objects[i].resources.paths))
	end
end

function objects:SetObjectState(id, state)
	local index = self.IndexByID(id)
	if (state < 1) or (state > #(self[index].resources.paths)) then
		log("error Invalid state\n")
		return
	end
	if (not index) then
		log("error Cant set object state\n")
		return
	end
	self[index].state = state
end

function objects:MoveObject(id, x, y)
	local index = objects:IndexByID(id)
	self[index].x = x
	self[index].y = y
	self[index].polygon:move(x, y)
end

function objects:DestroyObject(id)
	local index = self:IndexByID(id)
	if (not index) then
		log("error Cant destroy object\n")
		return
	end
	self[index] = nil
	self = CleanNils(self)
	log("Object " .. tostring(id) .. " destroyed\n")
end

function objects:CreateObject(id, colpath, ...) -- first collision image path then other paths
	local index = #self + 1
	log("Creating object " .. tostring(id) .. "\n")
	self[index] = {}
	self[index].id = id
	self[index].state = 1
	self[index].resources.imgs = {}
	self[index].resources.paths = {}
	self[index].x = 0
	self[index].y = 0
	local resnum = self:AddObjectResources(index, ...)
	assert(resnum, "No resources for object " .. tostring(index))
	log(tostring(resnum) .. " resources loaded for object " .. tostring(index) .. "\n")
	self[index].polygon = Polygon(objects.CollisionImage(colpath))
end

function objects:draw()
	for _, obj in ipairs(self) do
		--love.graphics.draw(ssss
	end
end

function objects.destroy(param)
	param = nil
	collectgarbage('collect')
end

function objects:create()
	local tbl = {}
	setmetatable(tbl, objects)
	return tbl
end 


 
