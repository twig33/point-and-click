require 'source.global.objects'
require 'source.text.dialogue'
  require ("source/objects/key")
intro = {}
intro.loaded = false
intro.objects = {}

function introreceivepoly(_type, msg) --object monitoring function
	log("Received polygon message type " .. tostring(_type) .. " message " .. tostring(msg) .. "\n")
	if (_type == MESSAGE_CLICK) then
		if (msg == 11 or msg == 12 or msg == 13) then
			intro.objects:DestroyObject(msg)
			dialogue.set(5, keyObject.comment)
			
		end
	end
end
function intro.load()
	intro = {}
	intro.bg = love.graphics.newImage('img/oz_screen6.jpg')
	intro.rect = HC.rectangle(200, 400, 400, 20)
	intro.couch = HC.rectangle(150, 500, 300, 50)
	intro.objects = objects:create()
	intro.objects:subscribe(introreceivepoly) --esli s tochkoi to intro.receivepoly budet nil v object subscribers
	intro.objects:CreateObject(11, 'img/keycol.png', 'img/key.png')
	intro.objects:MoveObject(11, 300, 100, 5)
	intro.objects:CreateObject(12, 11, 11)
	intro.objects:MoveObject(12, 475, 475, 1)
	intro.objects:CreateObject(13, keyObject.colImg, keyObject.image)
	intro.objects:MoveObject(13, 350, 450, 3)
end
function intro.unload()
	intro = nil
end
function intro.draw()
	love.graphics.draw(intro.bg)
	intro.rect:draw('fill')
	intro.couch:draw('fill')
	intro.objects:draw()
	love.graphics.print('Gay timer which should show when dialogue disappears I dont know how to make it stop at 0 and i dont care: '  .. result - love.timer.getTime(), 75, 0)
end	-- i can only imagine what adding talking animation is going to be like
function intro.update(dt)
	return
end