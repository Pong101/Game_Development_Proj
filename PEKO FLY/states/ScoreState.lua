--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

-- Reward Images
local Medal = love.graphics.newImage('medal.png')
local Belt = love.graphics.newImage('belt.png')
local Cup = love.graphics.newImage('first-place.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)

    -- 3 Tiers of medals depending on the score
    if self.score >= 3 and self.score < 5 then
        love.graphics.draw(Medal, VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 0, 1, 1, Medal:getWidth()/2, Medal:getHeight()/2)
        love.graphics.printf('You won a medal! GOOD JOB!', 0, 64, VIRTUAL_WIDTH, 'center')
    elseif self.score >= 5 and self.score < 10 then
        love.graphics.draw(Belt, VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 0, 1, 1, Belt:getWidth()/2, Belt:getHeight()/2)
        love.graphics.printf('You won a Champinship Belt! EXCELENT JOB!', 0, 64, VIRTUAL_WIDTH, 'center')
    elseif self.score >= 10 then
        love.graphics.draw(Cup, VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 0, 1, 1, Cup:getWidth()/2, Cup:getHeight()/2)
        love.graphics.printf('You won The Golden Cup! MARVELOUS JOB!', 0, 64, VIRTUAL_WIDTH, 'center') 
    else
        love.graphics.printf('BIG OOF! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end