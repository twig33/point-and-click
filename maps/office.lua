local text = {}
office = {}
poly = HC.polygon(60, 399,74, 468, 304, 563, 365,511,347,467)
function office.load()
	
end

function office.update(dt)

end

function office.draw()
	if gameState.room == 'Intro' then
	poly:draw('fill')
end
end