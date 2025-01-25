require("classes/Physics")
require("classes/GameObject")

function newProjectile(x, y, z, radius, direction, speed)
    projectile = newGameObject(x, y, z, 0, 1);

    projectile.direction = direction or "up"
    projectile.speed = speed or 1000
    projectile.destroyIt = false
    projectile.radius = radius or 5

    projectile.circleCollisor = newCircleCollisor(projectile);

    projectile.draw = function(self, mode)
        love.graphics.circle("fill", 
            self.transform.x, 
            self.transform.y, 
            self.transform.size * self.radius
        )
        self.circleCollisor:draw()
    end
     
    projectile.update = function(self, deltaTime) 
        self.circleCollisor:update(deltaTime)

        if self.direction == "up" then
            self.transform.y = self.transform.y - self.speed * deltaTime
        end

        if self.circleCollisor.globalY < self.circleCollisor.radius then
            self.destroyIt = true
        end

        for i,o in ipairs(gameObjects) do
            -- ALGUNS GAMEOBJECTS NÃO TEM COLISORES, ISSO ESTÁ DANDO PROBLEMAS
            if o.circleCollisor == nil then
                goto continue
            end
            if checkCircleToCircleCollision(self, o) then
                o.circleCollisor.color.r = 0  
                o.circleCollisor.color.g = 1  
                o.circleCollisor.color.b = 0  
            else
                o.circleCollisor.color.r = 1  
                o.circleCollisor.color.g = 1  
                o.circleCollisor.color.b = 1  
            end
            ::continue::
        end
    end

    return projectile
end