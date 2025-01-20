require("classes/Shape")

function newCirc(x, y, speed, radius)
    local circ = {}
    shape.extends(circ, x, y, speed)

    circ.radius = radius or math.random(50, 200)
    circ.draw = function(self) 
        love.graphics.circle("line", self.x, self.y, self.radius)
    end

    return circ
end