--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local goldMedal = love.graphics.newImage('images/gold.png')
local silverMedal = love.graphics.newImage('images/silver.png')
local bronzeMedal = love.graphics.newImage('images/bronze.png')

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
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    self:getMedal()    
    self.medalHeight = 0;

    if self.score > 0 then
        love.graphics.draw(medal, VIRTUAL_WIDTH / 2 - medal:getWidth() / 2, 
            VIRTUAL_HEIGHT / 2 - 20)
        self.medalHeight = medal:getHeight()
    end

    love.graphics.printf('Press Enter to Play Again!', 0, VIRTUAL_HEIGHT / 2 + self.medalHeight - 10, VIRTUAL_WIDTH, 'center')
end

--[[
    To get a medal picture to be display in render()
]]
function ScoreState:getMedal()
    medal = bronzeMedal
    if self.score > 4 then
        medal = goldMedal
    elseif self.score > 2 then
        medal = silverMedal
    end
end