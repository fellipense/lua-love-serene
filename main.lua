require("classes/Rectangle")
require("classes/Circle")
tick = require "libs/tick"
audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
shapes = {}

function love.load()
	love.audio.play(audio1)
	love.graphics.setColor(0.5, 0.5, 1)
	love.window.setTitle("serene")
end

function love.update(deltaTime)
	tick.update(deltaTime)
end

function love.draw()
	for i,s in ipairs(shapes) do
		s:draw()
	end

	love.graphics.print(love.graphics.getWidth())
end

function love.keypressed(key)
	if key == "1" then
		table.insert(shapes, newRectangle(nil, nil, 100))
	end

	if key == "2" then
		table.insert(shapes, newCircle(nil, nil, 100))
	end
end
