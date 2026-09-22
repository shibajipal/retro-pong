Player = Class{}

function Player:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dY = 0
    self.score = 0
end

function Player:update(dt)
    if self.dY < 0 then
        self.y = math.max(55, self.y + self.dY * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height - 5, self.y + self.dY * dt)
    end
end

function Player:render(color)
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end