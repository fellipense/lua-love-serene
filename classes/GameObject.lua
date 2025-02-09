require("classes/Transform")
function newGameObject(x, y, z, r, size)
    
    local gameObject = {}

    gameObject.display = true
    gameObject.destroyIt = false
    gameObject.transform = newTransform(x, y, z, r, size)
    gameObject.update = function(deltaTime) 
        return true
    end

    return gameObject
end

