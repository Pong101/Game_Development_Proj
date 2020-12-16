--require push
push = require 'push'
--require class
Class = require 'class'
--require bird
require 'Bird'

--require pipe
require 'Pipe'

--require pipe_pair
require 'PipePair'

-- code related to game state and state machines
require 'StateMachine'
require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')

local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local GROUND_LOOPING_POINT = 514

local bird = Bird()

local pipePairs = {}

local spawnTimer = 0

local lastY = -PIPE_HEIGHT + math.random(80) + 20

-- scrolling to pause the game when the bird collides with the pipe
local scrolling = true

function love.load()
    --Filter
    love.graphics.setDefaultFilter('nearest','nearest')

    --sets the random num
    math.randomseed(os.time())


    love.window.setTitle('Flying berd')

    -- initialize our nce-looking retro text fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),
        ['pause_unpause'] = love.audio.newSource('pause_unpause.mp3', 'static'),
        ['music'] = love.audio.newSource('marios_way.mp3', 'static')
    }

    -- kick off music
    sounds['music']:setLooping(true)
    sounds['music']:play()


    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true

    })

    -- initialize state machine
    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState()end,
        ['score'] = function() return ScoreState() end
        
        
    }
    gStateMachine:change('title')

    -- initialize input table
    love.keyboard.keysPressed = {}

    -- initialize mouse input table
    love.mouse.keyPressed = {}


end

function love.resize (w , h)
    push:resize (w,h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end


function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end


function love.update(dt)

    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT
    
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)% GROUND_LOOPING_POINT
    
    gStateMachine:update(dt)
    -- reset input table
    love.keyboard.keysPressed = {}
    -- reset mouse input table
    love.mouse.buttonsPressed = {}

end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    push:finish()
end