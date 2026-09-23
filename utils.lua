local utils = {}

utils.sounds = {
        ["paddle_hit"] = love.audio.newSource("assets/sounds/paddle_hit.wav", "static"),
        ["score"] = love.audio.newSource("assets/sounds/score.wav", "static"),
        ["wall_hit"] = love.audio.newSource("assets/sounds/wall_hit.wav", "static"),
        ["large_paddle_activate"] = love.audio.newSource("assets/sounds/large_paddle_activate.wav", "static"),
    }

return utils