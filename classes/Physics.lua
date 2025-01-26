function newCircleCollisor(parent, radius, xOffset, yOffset, z)
    local circleCollisor = {}
    circleCollisor.parent = parent
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

        for i,o in ipairs(gameObjects) do

            if o.rectangleCollisor ~= nil then
                local closePoint = {}
                closePoint.x = clamp(
                    o.rectangleCollisor.globalX,
                    o.rectangleCollisor.globalX + o.rectangleCollisor.width,
                    self.globalX
                )
                closePoint.y = clamp(
                    o.rectangleCollisor.globalY,
                    o.rectangleCollisor.globalY + o.rectangleCollisor.height,
                    self.globalY
                )
                love.graphics.line(
                    self.globalX, self.globalY, 
                    closePoint.x, closePoint.y
                )
            end
        end
    end

    circleCollisor.update = function(self, deltaTime)
        self.globalX = parent.transform.x + circleCollisor.xOffset
        self.globalY = parent.transform.y + circleCollisor.yOffset

        for i,o in ipairs(gameObjects) do

            if o.circleCollisor ~= nil then
                
                if checkCircleToCircleCollision(self, o.circleCollisor) then
                    self.color.r = 1
                    self.color.g = 0
                    self.color.b = 0
                end
                    self.color.r = 0
                    self.color.g = 1
                    self.color.b = 0
            end

            if o.rectangleCollisor ~= nil then

                if checkCircleToRectangleCollision(self, o.rectangleCollisor) then
                    self.color.r = 1
                    self.color.g = 0
                    self.color.b = 0
                else 
                    self.color.r = 0
                    self.color.g = 1
                    self.color.b = 0
                end
            end
        end
    end

    return circleCollisor
end

function newRectangleCollisor(parent, width, height, xOffset, yOffset, z)
    local rectangleCollisor = {}
    rectangleCollisor.parent = parent
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

        for i,o in ipairs(gameObjects) do

            if o == self.parent then goto continue end
            
            if o.rectangleCollisor ~= nil then
                if checkRectangleToRectangleCollision(self, o.rectangleCollisor) then
                    self.color.r = 1
                    self.color.g = 0
                    self.color.b = 0
                else
                    self.color.r = 0
                    self.color.g = 1
                    self.color.b = 0
                end
            end

            -- testando git
            -- mais um teste

            if o.circleCollisor ~= nil then

                if checkCircleToRectangleCollision(o.circleCollisor, self) then
                    self.color.r = 1
                    self.color.g = 0
                    self.color.b = 0
                else
                    self.color.r = 0
                    self.color.g = 1
                    self.color.b = 0
                end
            end

            ::continue::
        end
    end

    return rectangleCollisor
end

function checkCircleToCircleCollision(a, b)

    return (a.globalX - b.globalX)^2 + 
        (a.globalY - b.globalY)^2 < 
        (a.radius + b.radius)^2
end

function checkCircleToRectangleCollision(a, b)
    local closerPoint = {}

    closerPoint.x = clamp(
        b.globalX,
        b.globalX + b.width,
        a.globalX
    )

    closerPoint.y = clamp(
        b.globalY,
        b.globalY + b.height,
        a.globalY
    )

    return (a.globalX - closerPoint.x)^2 + 
        (a.globalY - closerPoint.y)^2 < 
        (a.radius)^2
end

function checkRectangleToRectangleCollision(a, b)

    return a.globalY < b.globalY + b.height
        or a.globalX + a.width > b.globalX
        or a.globalY + a.height > b.globalY
        or a.globalX < b.globalX + b.width
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

function clamp(min, max, value)
    if value > max 
        then return max
    elseif value < min 
        then return min
    else 
        return value 
    end
end