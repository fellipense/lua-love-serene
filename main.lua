require("classes/Rect")
require("classes/Circ")

function love.load()
	audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
	tick = require "libs/tick"
	sheep = love.graphics.newImage("sprites/sheep.png")

	shapes = {}

	love.audio.play(audio1)
	love.graphics.setBackgroundColor(1, 1, 1)
	love.graphics.setColor(0.5, 0.5, 1)
end

function love.update(deltaTime)
	tick.update(deltaTime)

	for i,s in ipairs(shapes) do
		s:update(deltaTime)
	end
end

function love.draw()
	for i,r in ipairs(shapes) do
		r:draw()
	end

	love.graphics.draw(sheep, 100, 100)
end

function love.keypressed(key)
	if key == "1" then
		table.insert(shapes, newRect(nil, nil, 100))
	end

	if key == "2" then
		table.insert(shapes, newCirc(nil, nil, 100))
	end
end
