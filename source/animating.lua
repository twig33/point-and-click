local anim8 = require 'source.lib.anim8.anim8'
require 'source.objects.key'
local image, animation
adachi = {}

  
function adachi.load()
  image = love.graphics.newImage('img/adachi.png')
  g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
animation = anim8.newAnimation(g('1-8',1), 0.1)
adachi.y = 350
adachi.x = 250
adachi.vel = 100
adachi.hitbox = HC.circle(40,40,20)
adachi.animations = {
 up =  anim8.newAnimation(g('5-8',3), 0.1),	
 down = anim8.newAnimation(g('1-4',3),0.1),
 left = anim8.newAnimation(g('15-18',3),0.1),
 right = anim8.newAnimation(g('18-20',4),0.1)
}
local keyDown 
adachi.animation = animation
end
gameState = {}
function adachi.unload()
image = nil
animation = nil
adachi = nil
end

function adachi.update(dt)

	adachi.movement(dt)
	adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)		--Important: make gamestate a part of
  for shape, delta in pairs(HC.collisions(adachi.hitbox)) do				--animating.lua or change it to something
    if shape:collidesWith(adachi.hitbox) then	
	adachi.keypressed(keyDown,dt)
    end
end

adachi.animation:update(dt)
end



function adachi.keypressed(key,dt)
   if keyDown == "escape" then
      love.event.quit()
   end

end
function adachi.draw()
adachi.hitbox:draw('fill')
  adachi.animation:draw(image, gameState.player.x, gameState.player.y)
 for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
shape:draw('fill')
end

--love.graphics.print( love.timer.getTime(), gameState.player.x, gameState.player.y)
--dialogue.draw(keyObject.comment, gameState.player.x, gameState.player.y)
end

function adachi.movement(dt)
wDown = false
sDown = false
aDown = false
dDown = false
if love.keyboard.isDown("w") then 
		wDown = true
   		gameState.player.y  = gameState.player.y  - 100 * dt
adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
 		for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
  		 if shape:collidesWith(adachi.hitbox) then	
			gameState.player.y  = gameState.player.y + 100 * dt
			adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
		 end
		end
  		adachi.animation = adachi.animations.up;
end
  

if love.keyboard.isDown("s") then
		sDown = true
		gameState.player.y  = gameState.player.y + 100 * dt
adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
		adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
 		for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
   		 if shape:collidesWith(adachi.hitbox) then	
			gameState.player.y  = gameState.player.y - 100 * dt
			adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
		 end
		end
	        adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
  		adachi.animation = adachi.animations.down;
 
  end
  if love.keyboard.isDown("a") then 
	 gameState.player.x  = gameState.player.x - 100 * dt
   	 adachi.animation = adachi.animations.left;
adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
 	 for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
	  if shape:collidesWith(adachi.hitbox) then	
		gameState.player.x  = gameState.player.x + 100 * dt
		adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
	 end
	end
	aDown = true
  end
  if love.keyboard.isDown("d") then 
	dDown = true
   	gameState.player.x  = gameState.player.x + 100 * dt
adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
 	for shape, delta in pairs(HC.collisions(adachi.hitbox)) do
   	 if shape:collidesWith(adachi.hitbox) then	
		gameState.player.x  = gameState.player.x - 100 * dt
		adachi.hitbox:moveTo(gameState.player.x+15, gameState.player.y+15)
	 end
	end
   adachi.animation = adachi.animations.right;
 end

end