Player = Class{}
local utils = require "utils"
function Player:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dY = 0
    self.score = 0
    self.large_paddle_active = false
    self.large_paddle_timer = 0
end

function Player:update(dt)
    if self.dY < 0 then
        self.y = math.max(55, self.y + self.dY * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height - 5, self.y + self.dY * dt)
    end
end

function Player:large_paddle_activate()
    self.large_paddle_active = true
    self.large_paddle_timer = 5
    utils.sounds["large_paddle_activate"]:play()
end

function Player:large_paddle_deactivate()
    self.large_paddle_active = false
    self.large_paddle_timer = 0
end

function Player:check_large_paddle_active()
    return self.large_paddle_active
end

function Player:check_large_paddle_timer()
end

function Player:increase_height(growthSpeed, dt)
    if self.height < 40 then
        self.height = math.min(40, self.height + growthSpeed * dt)
        self.y = self.y - growthSpeed * dt / 2
    end
end

function Player:decrease_height(growthSpeed, dt)
    if self.height > 20 then
        self.height = math.max(20, self.height - growthSpeed * dt)
        self.y = self.y + growthSpeed * dt / 2
    end
end 
function Player:handle_large_paddle_powerup(growthSpeed, dt)
    if self.large_paddle_active then
        if self.large_paddle_timer > 0 then
            self:increase_height(growthSpeed, dt)
            self.large_paddle_timer = self.large_paddle_timer - dt
        else
            self:large_paddle_deactivate()
        end
    else
        self:decrease_height(growthSpeed, dt)
    end
end

function Player:render(color)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end