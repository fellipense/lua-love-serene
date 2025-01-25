function newCircleCollisor(parent, radius, xOffset, yOffset, z)
    local circleCollisor = {}
    circleCollisor.xOffset = xOffset or 0
    circleCollisor.yOffset = yOffset or 0
    circleCollisor.z = z or 1
    circleCollisor.radius = radius or parent.radius or 10
    circleCollisor.color = {}
    circleCollisor.color.r = 0
    circleCollisor.color.g = 1
    circleCollisor.color.b = 0

    circleCollisor.globalX = parent.transform.x + circleCollisor.xOffset
    circleCollisor.globalY = parent.transform.y + circleCollisor.yOffset

    circleCollisor.draw = function(self, mode)
        love.graphics.setColor(self.color.r, self.color.g, self.color.b)
        love.graphics.circle(mode or "line", 
            self.globalX,
            self.globalY, 
            self.radius
        )
        love.graphics.setColor(1, 1, 1)
    end

    circleCollisor.update = function(self, deltaTime)
        self.globalX = parent.transform.x + circleCollisor.xOffset
        self.globalY = parent.transform.y + circleCollisor.yOffset
    end

    return circleCollisor
end

function newRectangleCollisor(parent, width, height, xOffset, yOffset, z)
    local rectangleCollisor = {}
    rectangleCollisor.xOffset = xOffset or 0
    rectangleCollisor.yOffset = yOffset or 0
    rectangleCollisor.z = z or 1
    rectangleCollisor.width = width or parent.width or 10
    rectangleCollisor.height = height or parent.height or 10
    rectangleCollisor.color = {}
    rectangleCollisor.color.r = 0
    rectangleCollisor.color.g = 1
    rectangleCollisor.color.b = 0

    rectangleCollisor.globalX = parent.transform.x + rectangleCollisor.xOffset
    rectangleCollisor.globalY = parent.transform.y + rectangleCollisor.yOffset

    rectangleCollisor.centralize = function(self)
        self.xOffset = self.width/2 * -1
        self.yOffset = self.height/2 * -1
    end

    rectangleCollisor.draw = function(self, mode)
        love.graphics.setColor(self.color.r, self.color.g, self.color.b)
        love.graphics.rectangle(mode or "line", 
            self.globalX,
            self.globalY, 
            self.width,
            self.height
        )
        love.graphics.setColor(1, 1, 1)
    end

    rectangleCollisor.update = function(self, deltaTime)
        self.globalX = parent.transform.x + rectangleCollisor.xOffset
        self.globalY = parent.transform.y + rectangleCollisor.yOffset
    end

    return rectangleCollisor
end

function checkCircleToCircleCollision(a, b)

    return (a.globalX - b.globalX)^2 + 
        (a.globalY - b.globalY)^2 < 
        (a.radius + b.radius)^2
end

function checkCircleToBoundaryCollision(a, b)

    if b == "top" and a.globalY < a.radius then
        return true
    end

    if b == "right" and a.globalX + a.radius > love.graphics.getWidth() then
        return true
    end

    if b == "bottom" and a.globalY + a.radius > love.graphics.getHeight() then
        return true
    end

    if b == "left" and a.globalX < a.radius then
        return true
    end
end