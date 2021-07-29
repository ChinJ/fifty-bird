--[[
    PauseState Class
    Author: Chin Jeah Lune
    jeahlune91@gmail.com

    The PauseState class is used to pause the game so that player
    can have a break.
]]

PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.bird = {}
    self.pipePairs = {}
    self.timer = 0
    self.score = 0
    self.lastY = 0
end

function PauseState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play', {
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer,
            score = self.score,
            lastY = self.lastY,
        })
    end
end

function PauseState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()

    -- print pause and instructions
    love.graphics.printf('Paused', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press P to resume', 0, 100, VIRTUAL_WIDTH, 'center')
end

--[[
    Called when this state is transitioned to from another state.
]]
function PauseState:enter(params)
    if params then
        self.bird = params.bird
        self.pipePairs = params.pipePairs
        self.timer = params.timer
        self.score = params.score
        self.lastY = params.lastY
    end
end

--[[
    Called when this state changes to another state.
]]
function PauseState:exit()
    -- stop scrolling for the death/score screen
    scrolling = true
end