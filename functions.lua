function addGameObject(obj)
    table.insert(gameObjects, obj)
    table.sort(gameObjects, compareByZ)
end

function compareByZ(a, b)
    return a.transform.z < b.transform.z
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

function debug()
    for i,o in ipairs(gameObjects) do
        if o.transform == nil then goto continue end

        if o.rectangleCollisor == nil then goto continue end
        
        love.graphics.print(tostring(o.rectangleCollisor.colliding), o.transform.x + 25, o.transform.y)

        ::continue::
    end
 
	love.graphics.print(string.format("FPS: %d", fps), 10, 10)
	love.graphics.print(table.getn(gameObjects), love.graphics.getWidth() - 10)
end