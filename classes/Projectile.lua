require("classes/GameObject")
require("physics")

function newProjectile(author, x, y, z, radius, speed, direction)
    projectile = newGameObject(
        author.transform.x, 
        author.transform.y, 
        author.transform.z -1, 
        0, 
        1
    );

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

        if drawCollisors then
            self.circleCollisor:draw()
        end
    end
     
    projectile.update = function(self, deltaTime) 
        self.circleCollisor:update(deltaTime)

        if self.direction == "up" then
            self.transform.y = self.transform.y - self.speed * deltaTime
        end
        if self.direction == "right" then
            self.transform.x = self.transform.x + self.speed * deltaTime
        end
        if self.direction == "down" then
            self.transform.y = self.transform.y + self.speed * deltaTime
        end
        if self.direction == "left" then
            self.transform.x = self.transform.x - self.speed * deltaTime
        end

        if self.circleCollisor.colliding then
            self.destroyIt = true
        end
    end

    return projectile
end