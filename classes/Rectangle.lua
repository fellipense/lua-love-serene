require("classes/Shape")

function newRectangle(x, y, width, height)
	local rectangle = {}
	shape.extends(rectangle, x, y, "rectangle")

	rectangle.width = width or math.random(50, 200)
	rectangle.height = height or math.random(50, 200)
    rectangle.draw = function(self, mode) 
        love.graphics.rectangle(mode or "line", self.x, self.y, self.width, self.height)
    end

	return rectangle 
end