shape = {}
shape.extends = function(obj, x, y, speed)
    obj.x = x or math.random(0, 700)
    obj.y = y or math.random(0, 700)
    obj.speed = speed or math.random(100, 300)

	obj.update = function(self, deltaTime) 
		self.x = self.x + self.speed * deltaTime
	end
end