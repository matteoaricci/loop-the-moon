Astronaut = Class{}

function love.conf(t)
    t.console = true
end

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
    if GRAVITY < 0 then
        self.y = math.max(self.height, self.y + GRAVITY * dt) 
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + GRAVITY * dt)
    end

    if love.keyboard.wasPressed('space') then 
        GRAVITY = -GRAVITY
        self.flip = -self.flip
    end

    self.x = (self.x + CAMERA_SCROLL_SPEED * dt)
end

function Astronaut:render()
    love.graphics.draw(self.image, math.floor(cameraScroll) + 40, math.floor(self.y), self.rotation, 1, self.flip, 0, self.height/2)
end