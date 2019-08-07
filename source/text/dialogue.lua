require 'source.animating'
 start = love.timer.getTime()
result = 0
current = " "
dialogue = {}

function dialogue.draw()			
if type(current) ~= "string"  then
    error("must be a string")
end
	if show then	--probably should do 1 line at a time?	
		love.graphics.setColor(255,255,255,255)
		love.graphics.print(current, gameState.player.x, gameState.player.y)
	end
end

function dialogue.update(dt)
	if  love.timer.getTime() > result then
		show = false
	end
end

function dialogue.set(pass, text)
	result = love.timer.getTime() + pass
	show = true
	current = text
end