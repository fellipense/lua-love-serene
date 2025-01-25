require("classes/GameObject")
require("classes/Input")
require("classes/Physics")
require("classes/Projectile")

require("player")
require("functions")

tick = require "libs/tick"
audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
gameObjects = {}
elapsedTime = 0

dummy = newGameObject(100, 100, nil, nil, nil)
dummy.radius = 100
dummy.circleCollisor = newCircleCollisor(dummy, nil, nil, nil, dummy.radius)
dummy.draw = function(self, mode)
	love.graphics.circle(mode or "line",
		self.transform.x,
		self.transform.y,
		self.radius
	)
	self.circleCollisor:draw()
end

addGameObject(dummy)


function love.load()
	love.audio.play(audio1)
	love.window.setTitle("serene")

	addGameObject(player)
end

function love.update(deltaTime)
	elapsedTime = elapsedTime + deltaTime
	tick.update(deltaTime)
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
	love.graphics.print(elapsedTime)
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