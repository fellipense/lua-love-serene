require("classes/Transform")
function newGameObject(x, y, z, r, size)
    
    local gameObject = {
        transform = newTransform(x, y, z, r, size)
    }

    return gameObject
end

