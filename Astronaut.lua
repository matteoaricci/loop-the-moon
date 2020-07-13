Astronaut = Class{}

local gravity = 50

function Astronaut:init()
    self.image = love.graphics.newImage('/images/astro-sprite-blue.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 10
    self.y = VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4

end

function Astronaut:update( dt )
    self.y = self.y + gravity * dt 
end

function Astronaut:render()
    love.graphics.draw(self.image, self.x, self.y)
end