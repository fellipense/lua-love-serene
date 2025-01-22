function newCircleCollisor(parent, xOffset, yOffset, z, radius)
    local circleCollisor = {}
    circleCollisor.xOffset = xOffset or 0
    circleCollisor.yOffset = xOffset or 0
    circleCollisor.z = z or 1
    circleCollisor.radius = radius or parent.transform.size or 10

    circleCollisor.globalX = parent.transform.x + circleCollisor.xOffset
    circleCollisor.globalY = parent.transform.y + circleCollisor.yOffset

    circleCollisor.draw = function(self, mode)
        love.graphics.setColor(0, 1, 0)
        love.graphics.circle(mode, 
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