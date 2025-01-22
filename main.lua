require("classes/GameObject")
require("classes/Input")
require("classes/Physics")
require("classes/Projectile")

require("player")
require("functions")

tick = require "libs/tick"
audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
gameObjects = {}

function love.load()
	love.audio.play(audio1)
	love.window.setTitle("serene")

	addGameObject(player)
end

function love.update(deltaTime)
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
end

function love.keypressed(key)
	if key == "space" then
		bullet = newProjectile(
			player.transform.x,
			player.transform.y,
			player.transform.z -1,
			nil, 10
		)
		addGameObject(bullet)
	end
end