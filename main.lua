require("classes/GameObject")
require("classes/Projectile")

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
dummy.rectangleCollider = newRectangleCollider(dummy)
dummy.draw = function(self, mode)
	love.graphics.rectangle(mode or "line",
		self.transform.x,
		self.transform.y,
		self.width,
		self.height
	)

	if drawColliders then
		self.rectangleCollider:draw()
	end
end
dummy.update = function(self, deltaTime)

	if dummy.rectangleCollider.colliding then
		dummy.life = dummy.life -1
	end

	if dummy.life <= 0 then
		dummy.destroyIt = true
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