require("classes/Shape")

function newRect(x, y, speed, width, height)
	local rect = {}
	shape.extends(rect, x, y, speed)

	rect.width = width or math.random(50, 200)
	rect.height = height or math.random(50, 200)
    rect.draw = function(self) 
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    end

	return rect 
end