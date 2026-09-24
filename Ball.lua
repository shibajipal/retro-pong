Ball = Class{}
VIRTUAL_WIDTH = 432
function Ball:init(x, y, height, width)
    self.x = x
    self.y = y
    self.height = height
    self.width = width
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50) * 1.5
    self.curve = 0  
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50) * 1.5
    self.curve = 0
end

function Ball:collides(paddle)
    if self.x >= paddle.x + paddle.width or paddle.x >= self.x + self.width then
        return false
    end

    if self.y >= paddle.y + paddle.height or paddle.y >= self.y + self.height then
        return false
    end

    return true
end

function Ball:update(dt)
    self.dy = self.dy + self.curve * dt
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:apply_curve(paddle)
    self.dx = self.dx * 1.15
    self.dy = self.dy * 1.15
    local travelDist = VIRTUAL_WIDTH - 47.5
    local travelTime = travelDist / math.abs(self.dx)

    local targetY
    if self.y < 109 then
        targetY = math.random(200, 218)
    elseif self.y > 163 then
        targetY = math.random(55, 73)
    else
        if math.random(2) == 1 then
            targetY = math.random(55, 73)
        else
            targetY = math.random(200, 218)
        end
    end

    self.curve = 2 * (targetY - self.y - self.dy * travelTime) / (travelTime * travelTime)
    --if self.y < 109 then
        --self.curve = -self.curve
    --end
end
function Ball:render()
    --some fun testing lol
    --[[
    color_r = math.sin(os.time())
    color_g = 1
    color_b = math.cos(os.time())
    color_a = 1 

    love.graphics.setColor(color_r, color_g, color_b, color_a) 
    ]]
    if self.curve ~= 0 then
        love.graphics.setColor(1, 0, 0, 1)
    end
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- sprite-based ball experiment
    -- love.graphics.draw(self.image, self.x, self.y, 0, self.imageWidth / self.image:getWidth(), self.imageHeight / self.image:getHeight())
end