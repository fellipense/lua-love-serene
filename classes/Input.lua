function inputUpdate(deltaTime)
    if love.keyboard.isDown("a") then
        player.transform.x = player.transform.x - player.speed * deltaTime
    end
    if love.keyboard.isDown("w") then
        player.transform.y = player.transform.y - player.speed * deltaTime
    end
    if love.keyboard.isDown("s") then
        player.transform.y = player.transform.y + player.speed * deltaTime
    end
    if love.keyboard.isDown("d") then
        player.transform.x = player.transform.x + player.speed * deltaTime
    end
end