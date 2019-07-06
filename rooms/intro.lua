intro = {}
intro.loaded = false
--intro.objects = objects.create()
function intro.load()
	intro = {}
	intro.bg = love.graphics.newImage('img/oz_screen6.jpg')
	intro.rect = HC.rectangle(200, 400, 400, 20)
	intro.couch = HC.rectangle(150, 500, 300, 50)
	--objects.AddObject(intro.objects, 'img/titulo.png', 100,0, 0,0, 0,150)
end
function intro.unload()
	intro = nil
end
function intro.draw()
	love.graphics.draw(intro.bg)
	intro.rect:draw('fill')
	intro.couch:draw('fill')
	--objects.draw(intro.objects)
end
function intro.update(dt)
	return
end