function newCircleCollisor(parent, xOffset, yOffset, z, radius)
    local circleCollisor = {}
    circleCollisor.xOffset = xOffset or 0
    circleCollisor.yOffset = yOffset or 0
    circleCollisor.z = z or 1
    circleCollisor.radius = radius or parent.radius or 10
    circleCollisor.color = {}
    circleCollisor.color.r = 1
    circleCollisor.color.g = 1
    circleCollisor.color.b = 1

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

function checkCircleToCircleCollision(a, b)
    aCol = a.circleCollisor
    bCol = b.circleCollisor

    return (aCol.globalX - bCol.globalX)^2 + 
        (aCol.globalY - bCol.globalY)^2 < 
        (aCol.radius + bCol.radius)^2
end

function checkCircleToBoundaryCollision(a, b)
    aCol = a.circleCollisor

    if b == "top" and aCol.globalY < aCol.radius then
        return true
    end

    if b == "right" and aCol.globalX + aCol.radius > love.graphics.getWidth() then
        return true
    end

    if b == "bottom" and aCol.globalY + aCol.radius > love.graphics.getHeight() then
        return true
    end

    if b == "left" and aCol.globalX < aCol.radius then
        return true
    end
end