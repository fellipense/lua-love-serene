shape = {}
shape.extends = function(obj, x, y, type)
    obj.x = x or math.random(0, 700)
    obj.y = y or math.random(0, 700)
    obj.type = type or "rectangle"
end