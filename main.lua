push = require 'push'
Class = require 'class'
require 'Astronaut'

-- Class = require 'class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('images/space-bkgd.png')
local midground = love.graphics.newImage('images/looping-background.png')
local midground2 = love.graphics.newImage('images/looping-background2.png')
local midScroll = 0
local midScroll2 = 0

local LOOP_POINT = 171
local BACK_MOVE_SPEED = 30
local BACK_MOVE_SPEED2 = 15

local astro = Astronaut()


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Loop the Moon')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end
end

function love.update(dt)
    midScroll = (midScroll + BACK_MOVE_SPEED * dt)
    % LOOP_POINT 

    midScroll2 = (midScroll2 + BACK_MOVE_SPEED2 * dt)
    % (LOOP_POINT / 3)

    astro:update(dt)
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
    
    astro:render()

    push:finish()
end