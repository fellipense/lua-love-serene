function addGameObject(obj)
    table.insert(gameObjects, obj)
    table.sort(gameObjects, compareByZ)
end

function compareByZ(a, b)
    return a.transform.z < b.transform.z
end