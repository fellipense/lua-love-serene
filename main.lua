require("classes/GameObject")
require("classes/Input")
require("classes/Physics")

tick = require "libs/tick"
audio1 = love.audio.newSource("audio/C418-Aria_Math.mp3", "stream")
gameObjects = {}

function love.load()
	love.audio.play(audio1)
	love.graphics.setColor(0.5, 0.5, 1)
	love.window.setTitle("serene")

	playerScreenPadding = 20

	player = newGameObject(0, 0, 0, 0, 1)
	player.speed = 500
	player.sprite = love.graphics.newImage("sprites/ship.png")
	player.transform.x = player.sprite:getWidth()/2 + playerScreenPadding
	player.transform.y = love.graphics.getHeight() - (player.sprite:getHeight()/2 + playerScreenPadding)
	player.xPivot = player.sprite:getWidth()/2
	player.yPivot = player.sprite:getHeight()/2
	player.draw = function()
		love.graphics.draw(
			player.sprite, 
			player.transform.x, 
			player.transform.y, 
			player.transform.r,
			player.transform.size, player.transform.size,
			player.xPivot, player.yPivot
		)
	end

	table.insert(gameObjects, player)
end

function love.update(deltaTime)
	tick.update(deltaTime)
	inputUpdate(deltaTime)
end

function love.draw()
	for i,s in ipairs(gameObjects) do
		s:draw(mode)
	end
end

function love.keypressed(key)
end