local logfile = assert(io.open("log.txt", "a+"))

function log(str) 
	logfile:write(str)
end