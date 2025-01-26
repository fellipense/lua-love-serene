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
dummy.rectangleCollisor = newRectangleCollisor(dummy)
dummy.draw = function(self, mode)
	love.graphics.rectangle(mode or "line",
		self.transform.x,
		self.transform.y,
		self.width,
		self.height
	)

	if drawCollisors then
		self.rectangleCollisor:draw()
	end
end
dummy.update = function(deltaTime)
	dummy.rectangleCollisor:update(deltaTime)
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
		drawCollisors = true
		log()
	else
		drawCollisors = false
	end
end