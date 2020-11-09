Class = require "lib/class"
push = require "lib/push"

WINDOW_WIDTH = 1067
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 1067
VIRTUAL_HEIGHT = 600

PADDLE_SPEED = 350

DIMS = {
  58,
  90,
  128,
  176
}

Colors = {
  ["Topic"] = {0 / 255, 100 / 255, 170 / 255, 1},
  ["Green"] = {50 / 255, 200 / 255, 50 / 255, 1},
  ["Orange"] = {207 / 255, 158 / 255, 70 / 255},
  ["Yellow"] = {230 / 255, 216 / 255, 46 / 255}
}

retro_small = love.graphics.newFont("font/retro.ttf", 24)
retro_medium = love.graphics.newFont("font/retro.ttf", 36)
retro_big = love.graphics.newFont("font/retro.ttf", 78)

Textures = {
  ["bg"] = love.graphics.newImage("image/bg.jpg"),
  ["paddle"] = love.graphics.newImage("image/paddle.png"),
  ["block"] = love.graphics.newImage("image/block.png"),
  ["ball"] = love.graphics.newImage("image/ball.png")
}

backgroundWidth = Textures["bg"]:getWidth()
backgroundHeight = Textures["bg"]:getHeight()

function displayFPS()
  love.graphics.setFont(retro_small)
  love.graphics.setColor(0.2, 0.7, 0.2, 1)
  love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 15, 15)
end

require "lib/statemachine"
require "src/levelmaker"

require "src/paddle"
require "src/ball"
require "src/brick"

require "src/states/basestate"
require "src/states/start"
require "src/states/play"

gStateMachine =
  StateMachine {
  ["start"] = function()
    return StartState()
  end,
  ["play"] = function()
    return PlayState()
  end
}

require "lib/util"

gQuads = {
  ["paddles"] = GenerateQuadsPaddles(Textures["paddle"]),
  ["balls"] = GenerateQuadsBalls(Textures["ball"]),
  ["bricks"] = GenerateQuadsBricks(Textures["block"])
}
