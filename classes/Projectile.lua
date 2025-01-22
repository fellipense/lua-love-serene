require("classes/GameObject")

function newProjectile(x, y, z, direction, speed, size)
    projectile = newGameObject(x, y, z, 0, size);

    projectile.direction = direction or "up"
    projectile.speed = speed or 300
    projectile.destroyIt = false

    projectile.draw = function(self)
        love.graphics.circle("fill", self.transform.x, self.transform.y, self.transform.size)
    end
     
    projectile.update = function(self, deltaTime) 
        if self.direction == "up" then
            self.transform.y = self.transform.y - self.speed * deltaTime
        end

        if self.transform.y < 100 then
            self.destroyIt = true
        end
    end

    return projectile
end