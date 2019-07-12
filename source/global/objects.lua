Polygon = require 'source.lib.hardoncollider.polygon'
require 'source.global.PointWithinShape'
require 'source.debug.logging'
require 'source.global.message'

objects = {}
objects.__index = objects

--internal functions
function objects:IndexByID(id)
	for i=1,#self,1 do
		if (self[i].id == id) then
			return i
		end
	end
	log("error No object with id " .. tostring(id) .. "\n")
	return nil
end

function objects:AddObjectResources(index, path, ...)
	if (path ~= nil) then
		if (type(path) == 'number') then
			local resindex = self:IndexByID(path)
			local pathindex = #(self[index].resources.paths) + 1
			local imgindex = #(self[index].resources.imgs) + 1
			self[index].resources.paths[pathindex] = self[resindex].resources.paths[pathindex]
			self[index].resources.imgs[imgindex] = self[resindex].resources.imgs[imgindex]
			log("Added resource " .. self[index].resources.paths[pathindex] .. " from existing object id " .. tostring(path) .. "\n")
		else
			self[index].resources.paths[#(self[index].resources.paths) + 1] = path
			self[index].resources.imgs[#(self[index].resources.imgs) + 1] = love.graphics.newImage(path)
			log("Added resource " .. path .. "\n")
		end
		return self:AddObjectResources(index, ...)
	else
		return #(self[index].resources.paths)
	end
end

function objects.CollisionImage(path)
	local green = {}
	local imgdata = love.image.newImageData(path)
	local w = imgdata:getWidth()
	local h = imgdata:getHeight()
	local greenvertices = {}
	for y=0, h-1, 1 do
		for x=0, w-1, 1 do
			local r, g, b, a = imgdata:getPixel(x, y)
			if (r == 0 and g ~= 0 and b == 0) then --if pixel is green
				i=1
				while (i <= #green) do --look for place to insert (green is sorted biggest to smallest)
					if (green[i] <= g) then --if green at this place is smaller or equal can insert here
						for a=#green,i,-1 do --make space for the new green
							green[a + 1] =  green[a]
							greenvertices[a*2-1+2] = greenvertices[a*2-1]
							greenvertices[a*2+2] = greenvertices[a*2]
						end
						break
					end
					i = i + 1
				end
				green[i] = g
				greenvertices[i*2-1] = x
				greenvertices[i*2] = y
			end
		end
	end
	imgdata = nil
	log(tostring(#green) .. " vertices from " .. path)
	for i=1,#green,1 do
		log(" " .. tostring(green[i]))
	end
	log("\n")
	return unpack(greenvertices)
end

function objects:DispatchMessage(_type, msg)
	for _, s in ipairs(self.subscribers) do
		s(_type, msg)
	end
end

function objects:mousepressed(x, y, button, istouch, presses)
	local x, y = love.mouse.getPosition()
	for i=#self,1,-1 do
		if (PointWithinShape(self[i].polygon.vertices, x, y)) then
			self:DispatchMessage(MESSAGE_CLICK, self[i].id)
			return
		end
	end
end

--external functions
function objects:UnloadAllResources()
	for _, obj in ipairs(self) do
		obj.resources = nil
	end
	collectgarbage('collect')
end

function objects:LoadAllResources()
	for i=1, #self,1 do
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

function objects:MoveObject(id, x, y, z)
	local index = self:IndexByID(id)
	self[index].polygon:move(x - self[index].x, y - self[index].y) --polygon move function moves by, not to
	self[index].x = x
	self[index].y = y
	if (z ~= nil) and (z ~= self[index].z) then
		self[index].z = z
		copy = self[index] --original will be overwritten
		for i=1,#self,1 do
			if (self[i].z > z) then
				if (index < i) then
					for a=index,i-1,1 do
						self[a] = self[a+1]
					end
				elseif (i < index) then
					for a=i,index-1,-1 do
						self[a+1] = self[a]
					end
				end
				self[i] = copy
				return
			end
		end
	end
end

function objects:DestroyObject(id)
	local index = self:IndexByID(id)
	if (not index) then
		log("error Cant destroy object\n")
		return
	end
	TableDelete(self, index)
	log("Object " .. tostring(id) .. " destroyed\n")
end

function objects:CreateObject(id, colpath, ...) -- first collision image path then other paths
	local index = #self + 1
	log("Creating object " .. tostring(id) .. "\n")
	self[index] = {}
	self[index].id = id
	self[index].state = 1
	self[index].resources = {}
	self[index].resources.imgs = {}
	self[index].resources.paths = {}
	self[index].x = 0
	self[index].y = 0
	self[index].z = 0
	local resnum = self:AddObjectResources(index, ...)
	assert(resnum, "No resources for object " .. tostring(index))
	log(tostring(resnum) .. " resources loaded for object " .. tostring(id) .. "\n")
	if (type(colpath) == 'number') then
		log("Loading polygon data from existing object id " .. tostring(colpath) .. "\n")
		local resindex = self:IndexByID(colpath)
		self[index].polygon = self[resindex].polygon:clone()
		self[index].polygon:move(0 - self[resindex].x, 0 - self[resindex].y)
	else
		self[index].polygon = Polygon(objects.CollisionImage(colpath))
	end
end

function objects:subscribe(func)
	assert(func ~= nil, "fuck")
	self.subscribers[#self.subscribers + 1] = func
end

function objects:draw()
	for _, obj in ipairs(self) do
		love.graphics.setColor(1,1,1)
		love.graphics.draw(obj.resources.imgs[obj.state], obj.x, obj.y)
		love.graphics.setColor(0,0.75,0)
		love.graphics.polygon('line', obj.polygon:unpack())
	end
end

function objects:update(dt)
	return
end

function objects:destroy()
	self = nil
	collectgarbage('collect')
end

function objects:create()
	local tbl = {}
	setmetatable(tbl, objects)
	tbl.subscribers = {}
	SubscribeToClick(tbl)
	return tbl
end 