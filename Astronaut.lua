Astronaut = Class{}

local gravity = 150

function Astronaut:init()
    self.image = love.graphics.newImage('/images/astro-sprite-blue.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.flip = 1
    self.rotation = 0

    self.x = VIRTUAL_WIDTH / 10
    self.y = VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4

end

function Astronaut:update( dt )
    self.y = self.y + gravity * dt 

    if love.keyboard.wasPressed('space') then 
        gravity = -gravity
        self.flip = -self.flip
    end
end

function Astronaut:render()
    love.graphics.draw(self.image, self.x, self.y, self.rotation, 1, self.flip, 0, self.height/2)
end