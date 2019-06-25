local text = {}
office = {}

function office.load()
	
end

function office.update(dt)

end

function office.draw()
	if gameState.room == 'Intro' then
	rect:draw('fill')
	couch:draw('fill')
end
end