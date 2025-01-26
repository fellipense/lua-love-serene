require("classes/GameObject")
require("classes/Input")
require("classes/Physics")
require("classes/Projectile")

require("player")
require("functions")

audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
gameObjects = {}
elapsedTime = 0
fps = 0

dummy = newGameObject(100, 100, nil, nil, nil)
dummy.width = 100
dummy.height = 100
dummy.rectangleCollisor = newRectangleCollisor(dummy, nil, nil, 10, 10)
dummy.draw = function(self, mode)
	love.graphics.rectangle(mode or "line",
		self.transform.x,
		self.transform.y,
		self.width,
		self.height
	)
	self.rectangleCollisor:draw()
end

dummy.update = function(deltaTime)
	dummy.rectangleCollisor:update(deltaTime)
end

addGameObject(dummy)


function love.load()
	love.audio.play(audio1)
	love.window.setTitle("serene")

	addGameObject(player)
end

function love.update(deltaTime)
	if elapsedTime + deltaTime > math.ceil(elapsedTime) then 
		fps = math.floor(1 / deltaTime);
	end

	elapsedTime = elapsedTime + deltaTime
	inputUpdate(deltaTime)

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
	love.graphics.print(string.format("FPS: %d", fps), 10, 10)
	love.graphics.print(table.getn(gameObjects), love.graphics.getWidth() - 10)
	debug()
end

function love.keypressed(key)
	if key == "space" then
		local bullet = newProjectile(
			player.transform.x,
			player.transform.y,
			player.transform.z -1
		)
		addGameObject(bullet)
	end
end
