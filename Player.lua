Player = Class{}
local utils = require "utils"
function Player:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.score = 0
    self.large_paddle_active = false
    self.large_paddle_timer = 0
    self.curve_shot_active = false
    self.disorient = false
    self.disorient_timer = 0
    self.powerup_popup_text = nil
    self.powerup_popup_timer = 0
    self.powerup_popup_duration = 0.9
    self.powerup_popup_color = {1, 0.784, 0.341}
end

function Player:update(dt)
    if self.dy < 0 then
        self.y = math.max(55, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height - 5, self.y + self.dy * dt)
    end

    if self.powerup_popup_timer > 0 then
        self.powerup_popup_timer = math.max(0, self.powerup_popup_timer - dt)
    end
end

function Player:show_powerup_popup(text, color)
    self.powerup_popup_text = text
    self.powerup_popup_timer = self.powerup_popup_duration
    self.powerup_popup_color = color or {1, 0.784, 0.341}
end

function Player:render_powerup_popup(font)
    if not self.powerup_popup_text or self.powerup_popup_timer <= 0 then
        return
    end

    local progress = 1 - self.powerup_popup_timer / self.powerup_popup_duration
    local scale = 1 + 0.45 * math.max(0, 1 - progress * 8)
    local alpha = math.min(1, self.powerup_popup_timer / 0.25)
    local textWidth = font:getWidth(self.powerup_popup_text)
    local centerX

    if self.x < VIRTUAL_WIDTH / 2 then
        centerX = self.x + self.width + textWidth / 2 + 5
    else
        centerX = self.x - textWidth / 2 - 5
    end

    local centerY = self.y + self.height / 2 - progress * 10
    love.graphics.push()
    love.graphics.translate(centerX, centerY)
    love.graphics.scale(scale, scale)
    love.graphics.rotate(self.x < VIRTUAL_WIDTH / 2 and -0.12 or 0.12)
    love.graphics.setFont(font)
    love.graphics.setColor(0.05, 0.07, 0.1, alpha * 0.9)
    love.graphics.printf(self.powerup_popup_text, -textWidth / 2 + 1, 1, textWidth, "center")
    love.graphics.setColor(self.powerup_popup_color[1], self.powerup_popup_color[2], self.powerup_popup_color[3], alpha)
    love.graphics.printf(self.powerup_popup_text, -textWidth / 2, 0, textWidth, "center")
    love.graphics.pop()
end

function Player:large_paddle_activate()
    self.large_paddle_active = true
    self.large_paddle_timer = 5
    self:show_powerup_popup("BIG PADDLE!")
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