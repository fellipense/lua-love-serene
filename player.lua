require("classes/GameObject")
require("classes/Projectile")
require("input")

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
player.destroyIt = false

player.update = function(self, deltaTime)
    player.rectangleCollisor:update(deltaTime)
    player.rectangleCollisor:centralize()

    if input.up then
        player.transform.y = player.transform.y - player.speed * deltaTime
    end

    if input.right then
        player.transform.x = player.transform.x + player.speed * deltaTime
    end

    if input.down then
        player.transform.y = player.transform.y + player.speed * deltaTime
    end

    if input.left then
        player.transform.x = player.transform.x - player.speed * deltaTime
    end

    if input.press.action then
        input.press.action = false
        addGameObject(newProjectile(player))
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