Ball = Class{}

function Ball:init(x, y, height, width)
    self.x = x
    self.y = y
    self.height = height
    self.width = width
    self.dX = math.random(2) == 1 and -100 or 100
    self.dY = math.random(-50, 50) * 1.5

end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2
    self.dX = math.random(2) == 1 and -100 or 100
    self.dY = math.random(-50, 50) * 1.5
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
    self.x = self.x + self.dX * dt
    self.y = self.y + self.dY * dt
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
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    -- sprite-based ball experiment
    -- love.graphics.draw(self.image, self.x, self.y, 0, self.imageWidth / self.image:getWidth(), self.imageHeight / self.image:getHeight())
end