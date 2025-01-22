require("classes/GameObject")
require("classes/Input")
require("classes/Physics")
require("classes/Projectile")

require("player")

tick = require "libs/tick"
audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
gameObjects = {}
destroyIt = false

function love.load()
	love.audio.play(audio1)
	love.graphics.setColor(0.5, 0.5, 1)
	love.window.setTitle("serene")

	table.insert(gameObjects, player)
end

function love.update(deltaTime)
	tick.update(deltaTime)
	inputUpdate(deltaTime)

	for i,s in ipairs(gameObjects) do
		s:update(deltaTime)
		if destroyIt then
			table.remove(s)
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
			player.transform.z,
			"up", 100, 100
		)
		table.insert(gameObjects, bullet)
	end
end