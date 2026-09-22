push = require "push"
Class = require "class"
require "Player"
require "Ball"

local shader

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 250

local keys = {w = false,
              s = false,
              up = false,
             down = false}

local cyan = {0.0, 0.898, 1.0}
local lavender = {0.769, 0.710, 0.992}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("asffsfaf")
    smallFont = love.graphics.newFont("assets/font.ttf", 8)
    largeFont = love.graphics.newFont("assets/font.ttf", 16)
    scoreFont = love.graphics.newFont("assets/font.ttf", 24)

    sounds = {
        ["paddle_hit"] = love.audio.newSource("assets/sounds/paddle_hit.wav", "static"),
        ["score"] = love.audio.newSource("assets/sounds/score.wav", "static"),
        ["wall_hit"] = love.audio.newSource("assets/sounds/wall_hit.wav", "static")
    }

    

    love.graphics.setFont(smallFont)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true 
    })

    shader = love.graphics.newShader("assets/crt.glsl")

    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = "normal", canvas = true })
    push.setShader(shader)
    player1 = Player(20, 60, 5, 20)
    player2 = Player(VIRTUAL_WIDTH - 22.5, VIRTUAL_HEIGHT - 30, 5, 20)
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_WIDTH / 2 - 2, 4, 4)


    servingPlayer = 1
    winningPlayer = 1
    gameState = "start"
end

function love.resize(w, h)
    push.resize(w, h)
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
       if gameState == "start" then
        gameState = "serve"
       elseif gameState == "serve" then
        gameState = "play"
       elseif gameState == "done" then
        gameState = "serve"
        ball:reset()
        player1.score = 0
        player2.score = 0
        if winningPlayer == 1 then
            servingPlayer = 2
        else
            servingPlayer = 1
        end
       end 
    end
    keys[key] = true
end

function love.keyreleased(key)
    keys[key] = false
end

function love.update(dt)
    if gameState == "serve" then
        ball.dY = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dX = math.random(140, 200)
        else
            ball.dX = -math.random(140, 200)
        end
    elseif gameState == "play" then
        if ball:collides(player1) then
            ball.dX = -ball.dX * 1.03
            ball.x = player1.x + player1.width 
            if ball.dY < 0 then
                ball.dY = -math.random(10, 150)
            else
                ball.dY = math.random(10, 150)
            end
            sounds["paddle_hit"]:play()
        end

        if ball:collides(player2) then
            ball.dX = -ball.dX * 1.03
            ball.x = player2.x - ball.width
            if ball.dY < 0 then
                ball.dY = -math.random(10, 150)
            else
                ball.dY = math.random(10, 150)
            end
            sounds["paddle_hit"]:play()
        end

        if ball.y <= 55 then 
            ball.y = 55
            ball.dY = -ball.dY
            sounds["wall_hit"]:play()
        end

        if ball.y >= VIRTUAL_HEIGHT - ball.height - 5 then
            ball.y = VIRTUAL_HEIGHT - ball.height - 5
            ball.dY = -ball.dY
            sounds["wall_hit"]:play()
        end

        if ball.x <= 0 then
            player2.score = player2.score + 1
            sounds["score"]:play()
            servingPlayer = 1

            if player2.score == 5 then
                winningPlayer = 2
                gameState = "done"
            else
                gameState = "serve"
                ball:reset()
            end
        end

        if ball.x >= VIRTUAL_WIDTH then
            player1.score = player1.score + 1
            sounds["score"]:play()
            servingPlayer = 2

            if player1.score == 5 then
                winningPlayer = 1
                gameState = "done"
            else
                gameState = "serve"
                ball:reset()
            end
        end
    end
    if keys.w then
        player1.dY = -PADDLE_SPEED
    elseif keys.s then
        player1.dY = PADDLE_SPEED
    else
        player1.dY = 0
    end

    if keys.up then
        player2.dY = -PADDLE_SPEED
    elseif keys.down then
        player2.dY = PADDLE_SPEED
    else
        player2.dY = 0
    end

    if gameState == "play" then
        ball:update(dt)
    end
    player1:update(dt)
    player2:update(dt)
end

function love.draw()
    push.start()
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if gameState == "start" then
        love.graphics.setFont(smallFont)
        love.graphics.printf("Hello World!", 0, 10, VIRTUAL_WIDTH, "center")
        love.graphics.printf("Press Enter to start the game!", 0, 20, VIRTUAL_WIDTH, "center")
    elseif gameState == "serve" then
        love.graphics.setFont(smallFont)
        love.graphics.printf("Player " .. tostring(servingPlayer) .. "'s serve!", 0, 10, VIRTUAL_WIDTH, "center")
        love.graphics.printf("Press Enter to serve!", 0, 20, VIRTUAL_WIDTH, "center")
    elseif gameState == "done" then
        love.graphics.setFont(largeFont)
        love.graphics.printf("Player " .. tostring(winningPlayer) .. " wins!", 0, 10, VIRTUAL_WIDTH, "center")
        love.graphics.setFont(smallFont)
        love.graphics.printf("Press Enter to restart the game!", 0, 40, VIRTUAL_WIDTH, "center")
    end

    displayScore()
    player1:render(cyan)
    player2:render(lavender)
    ball:render()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(5)
    love.graphics.rectangle("line", 2.5, 52.5, VIRTUAL_WIDTH - 5, VIRTUAL_HEIGHT - 55)
    love.graphics.rectangle("fill", VIRTUAL_WIDTH / 2, 52.5, 2, VIRTUAL_HEIGHT)
    displayFPS()

    shader:send("time", love.timer.getTime())
    shader:send("screenSize", {VIRTUAL_WIDTH, VIRTUAL_HEIGHT})
    push.finish()
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1.score), VIRTUAL_WIDTH / 2 - 50, 60)
    love.graphics.print(tostring(player2.score), VIRTUAL_WIDTH / 2 + 50, 60)
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0/255, 255/255, 0/255, 255/255)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end