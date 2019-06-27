local dir = love.filesystem.getSourceBaseDirectory()
local logfile = assert(io.open( dir.."/log.txt", "w"))

function log(str) 
	logfile:write(str)
end