local text = {}
office = {}
rect = HC.rectangle(200, 400, 400, 20)
couch = HC.rectangle(150, 500, 300, 50)
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