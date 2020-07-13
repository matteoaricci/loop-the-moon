push = require 'push'
Class = require 'class'
require 'Astronaut'
require 'Util'

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
GROUND = 1
SKY = 2


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    tiles = {}
    tilesheet = love.graphics.newImage('/images/tilesheet-astro.png')
    quads = GenerateQuads(tilesheet, 32, 32)

    mapWidth = 20
    mapHeight = 20

    for y = 1, mapHeight do 
        table.insert(tiles, {})

        for x = 1, mapWidth do 
            table.insert(tiles[y], {
               id = y < 3 and SKY or y > 17 and GROUND or null
            })
        end
    end

    math.randomseed(os.time())

    love.window.setTitle('Loop the Moon')

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

    for y = 1, mapHeight do 
        for x = 1, mapWidth do 
            local tile = tiles[y][x]
            love.graphics.draw(tilesheet, quads[tile.id], (x - 1) * 16, (y - 1) * 16)
        end
    end
    
    astro:render()

    push:finish()
end