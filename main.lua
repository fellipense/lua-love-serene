require("classes/GameObject")
require("classes/Projectile")
require("classes/Animator")

require("game")
require("player")
require("functions")
require("physics")
require("input")

audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")

dummy = newGameObject(100, 100, nil, nil, nil)
dummy.width = 100
dummy.height = 100
dummy.transform.z = 0
dummy.destroyIt = false
dummy.life = 3
dummy.timer = 0
dummy.sprite = love.graphics.newImage("sprites/vilao/idle/Sprite-1.png")
dummy.die = false
dummy.circleCollider = newCircleCollider(
	dummy, 
	dummy.sprite:getWidth()/2, 
	dummy.sprite:getWidth()/2, 
	dummy.sprite:getHeight()/2
)
dummy.animator = newAnimator(dummy, "idle")
dummy.animator:addAnimation("idle", "sprites/vilao/idle/", 2, 3)
dummy.animator:addAnimation("die", "sprites/vilao/Transform/", 5, 5)
dummy.animator:playAnimation("die")

dummy.draw = function(self)
	love.graphics.draw(dummy.sprite, dummy.transform.x, dummy.transform.y)
	love.graphics.print(dummy.animator.timer, dummy.transform.x, dummy.transform.y - 10)
	love.graphics.print(dummy.animator.step, dummy.transform.x, dummy.transform.y - 20)

	if drawColliders then
		self.circleCollider:draw()
	end
end

dummy.update = function(self, deltaTime)
	dummy.animator:update(deltaTime)

	if dummy.circleCollider ~= nil then
		if dummy.circleCollider.colliding then
			dummy.life = dummy.life -1
		end
	end

	if dummy.life <= 0 then
		dummy.die = true
	end

	if dummy.die then
		
		if dummy.animator.currentAnimation ~= "die" then
			dummy.animator:setAnimation("die")
		end

		dummy.timer = dummy.timer + deltaTime

		if dummy.circleCollider ~= nil then dummy.circleCollider = nil end

		if dummy.timer > 4 then
			dummy.destroyIt = true
		end
	end
end

function love.load()
	love.audio.play(audio1)
	love.window.setTitle("serene")

	addGameObject(player)
	addGameObject(dummy)
end

function love.update(deltaTime)

	if elapsedTime + deltaTime > math.ceil(elapsedTime) then 
		fps = math.floor(1 / deltaTime);
	end

	if input.press.debug then
		input.press.debug = false
		debug = not debug
	end

	elapsedTime = elapsedTime + deltaTime
	input.update(deltaTime)

	for i,s in ipairs(gameObjects) do
		s:update(deltaTime)
	end	

	for i,s in ipairs(gameObjects) do
		
		if s.rectangleCollider ~= nil then
			s.rectangleCollider:update(deltaTime)
		end

		if s.circleCollider ~= nil then
			s.circleCollider:update(deltaTime)
		end
	end

	for i,s in ipairs(gameObjects) do
		if s.destroyIt then
			table.remove(gameObjects, i)
		end
	end
end

function love.draw()
	for i,s in ipairs(gameObjects) do
		s:draw(mode)
	end
	
	if debug then
		drawColliders = true
		log()
	else
		drawColliders = false
	end
end