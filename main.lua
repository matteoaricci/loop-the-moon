push = require 'push'
Class = require 'class'
require 'Astronaut'
require 'Util'
require 'tiledmap'

-- Class = require 'class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288
FACTOR = 2

CAMERA_SCROLL_SPEED = 60 * FACTOR
GRAVITY = 200

local background = love.graphics.newImage('images/space-bkgd.png')
local midground = love.graphics.newImage('images/looping-background.png')
local midground2 = love.graphics.newImage('images/looping-background2.png')
local midScroll = 0
local midScroll2 = 0

local LOOP_POINT = 171
local BACK_MOVE_SPEED = 30 * 2
local BACK_MOVE_SPEED2 = 15 * 2

local astro = Astronaut()
GROUND = 2
SKY = 23
WHAT = 39

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    cameraScroll = 0

    _G.map = loadTiledMap('astro-map-two')

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then 
        love.event.quit()
    end
end

function love.keyboard.wasPressed( key )
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    midScroll = (midScroll + BACK_MOVE_SPEED * dt)
    % LOOP_POINT 

    midScroll2 = (midScroll2 + BACK_MOVE_SPEED2 * dt)
    % (LOOP_POINT / 3)

    astro:update(dt)

    cameraScroll = cameraScroll + CAMERA_SCROLL_SPEED * dt

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, 0, 0)

    love.graphics.draw(midground, -midScroll, 0)
    love.graphics.draw(midground, -midScroll + 171, 0)
    love.graphics.draw(midground, -midScroll + 342, 0)
    love.graphics.draw(midground, -midScroll + 513, 0)

    love.graphics.draw(midground2, -midScroll2, 0)
    love.graphics.draw(midground2, -midScroll2 + 57, 0)
    love.graphics.draw(midground2, -midScroll2 + 114, 0)
    love.graphics.draw(midground2, -midScroll2 + 171, 0)
    love.graphics.draw(midground2, -midScroll2 + 228, 0)
    love.graphics.draw(midground2, -midScroll2 + 285, 0)
    love.graphics.draw(midground2, -midScroll2 + 342, 0)
    love.graphics.draw(midground2, -midScroll2 + 399, 0)
    love.graphics.draw(midground2, -midScroll2 + 456, 0)
    love.graphics.draw(midground2, -midScroll2 + 513, 0)


    love.graphics.translate(-math.floor(cameraScroll), 0)

    _G.map:draw()
    
    astro:render()
    love.graphics.print(astro.x, astro.x, 0)
    love.graphics.print(astro.y, astro.x, 20)
    push:finish()
end