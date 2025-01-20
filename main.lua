require("classes/Rectangle")
require("classes/Circle")
tick = require "libs/tick"
audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
shapes = {}
player = {}

function love.load()
	love.audio.play(audio1)
	love.graphics.setColor(0.5, 0.5, 1)
	love.window.setTitle("serene")
	player = newRectangle(0, 0, 100, 100)
	table.insert(shapes, player)
	player.speed = 200
end

function love.update(deltaTime)
	tick.update(deltaTime)

	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed * deltaTime
	end
	if love.keyboard.isDown("w") then
		player.y = player.y - player.speed * deltaTime
	end
	if love.keyboard.isDown("s") then
		player.y = player.y + player.speed * deltaTime
	end
	if love.keyboard.isDown("d") then
		player.x = player.x + player.speed * deltaTime
	end
end

function love.draw()
	for i,s in ipairs(shapes) do
		s:draw()
	end
end

function love.keypressed(key)
	if key == "1" then
		table.insert(shapes, newRectangle(nil, nil, 100))
	end

	if key == "2" then
		table.insert(shapes, newCircle(nil, nil, 100))
	end
end