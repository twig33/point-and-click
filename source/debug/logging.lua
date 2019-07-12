local dir = love.filesystem.getSource()
local logfile = assert(io.open( dir.."/log.txt", "w"))

function log(str) 
	logfile:write(str)
end