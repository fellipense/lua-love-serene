require("classes/GameObject")

playerScreenPadding = 20
sprite = love.graphics.newImage("sprites/ship.png")

player = newGameObject(
    sprite:getWidth()/2 + playerScreenPadding, 
    love.graphics.getHeight() - (sprite:getHeight()/2 + playerScreenPadding), 
    0, 0, 1
)

player.sprite = sprite
player.speed = 200
player.xPivot = player.sprite:getWidth()/2
player.yPivot = player.sprite:getHeight()/2
player.rectangleCollisor = newRectangleCollisor(player, 30, 20)

player.update = function(deltaTime)
    player.rectangleCollisor:update(deltaTime)
    player.rectangleCollisor:centralize()

    for i,o in ipairs(gameObjects) do
        if o.rectangleCollisor == nil then
            goto continue
        end

        ::continue::
    end
end

player.draw = function(mode)
    
    if not player.display then return nil end

    love.graphics.draw(
        player.sprite, 
        player.transform.x, 
        player.transform.y, 
        player.transform.r,
        player.transform.size, player.transform.size,
        player.xPivot, player.yPivot
    )

    if drawCollisors then
        player.rectangleCollisor:draw()
    end
end