love.graphics.setDefaultFilter("nearest", "nearest")
local Player = require("player")
local Coin = require("coin")
local GUI = require("gui")
local Spike = require("spike")
local Stone = require("stone")
local Camera = require("camera")
local Enemy = require("enemy")
local Map = require("map")

function love.load()
    Enemy.loadAssets()
    Map:load()
    background = love.graphics.newImage("assets/background2.png")
    GUI:load()
    Player:load()

    sounds = {
        ['jump'] = love.audio.newSource('sfx/jump.wav', 'static'),
        ['music'] = love.audio.newSource('sfx/bgm.mp3', 'static'),
        ['damage'] = love.audio.newSource('sfx/damage.mp3', 'static'),
        ['coins'] = love.audio.newSource('sfx/coins.mp3', 'static')
    }

    -- kick off music
    sounds['music']:setLooping(true)
    sounds['music']:play()
end

function love.update(dt)
    World:update(dt)
    Player:update(dt)
    Coin.updateAll(dt)
    Spike.updateAll(dt)
    Stone.updateAll(dt)
    Enemy:updateAll(dt)
    GUI:update(dt)
    Camera:setPosition(Player.x, 0)
    Map:update(dt)

end

function love.draw()
    love.graphics.draw(background)
    Map.level:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)

    Camera:apply()
    Player:draw()
    Enemy:drawAll()
    Coin.drawAll()
    Spike.drawAll()
    Stone.drawAll()
    Camera:clear()

    GUI:draw()

end

function love.keypressed(key)
    Player:jump(key)
    if key == 'escape' then
        love.event.quit()
    end

end

function beginContact(a, b, collision)
    if Coin.beginContact(a, b, collision) then return end
    if Spike.beginContact(a, b, collision) then return end
    Enemy.beginContact(a, b, collision)
    Player:beginContact(a, b, collision)

end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)

end
