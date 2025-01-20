require("classes/Shape")

function newCircle(x, y, radius)
    local circle = {}
    shape.extends(circle, x, y, "circle")

    circle.radius = radius or math.random(50, 200)
    circle.draw = function(self, mode) 
        love.graphics.circle(mode or "line", self.x, self.y, self.radius)
    end

    return circle
end