function newEnemy(x, y, z, width, height, life)
    local dummy = newGameObject(x or 100, y or 100, nil, nil, nil)
    dummy.width = width or 100
    dummy.height = height or 100
    dummy.transform.z = z or 0
    dummy.destroyIt = false
    dummy.die = false
    dummy.life = life or 3
    dummy.timer = 0
    dummy.sprite = love.graphics.newImage("sprites/vilao/idle/Sprite-1.png")
    dummy.circleCollider = newCircleCollider(
        dummy, 
        dummy.sprite:getWidth()/2, 
        dummy.sprite:getWidth()/2, 
        dummy.sprite:getHeight()/2
    )
    dummy.animator = newAnimator(dummy, "idle")
    dummy.animator:addAnimation("idle", "sprites/vilao/idle/", 2, 3)
    dummy.animator:addAnimation("die", "sprites/vilao/Transform/", 5, 5)

    dummy.draw = function(self)
        love.graphics.draw(self.sprite, self.transform.x, self.transform.y)

        if drawColliders then
            self.circleCollider:draw()
        end
    end

    dummy.update = function(self, deltaTime)

        if self.circleCollider ~= nil then
            if self.circleCollider.colliding then
                self.life = self.life -1
            end
        end

        if self.life <= 0 then
            self.die = true
        end

        if self.die then

            self.circleCollider = nil
            if self.animator.currentAnimation ~= "die" then 
                self.animator:playAnimation("die")
            end

            if self.animator.event == "die-end" then
                self.destroyIt = true
            end
        end
    end

    return dummy
end