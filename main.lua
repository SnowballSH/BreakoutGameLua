require "src/CONST"

function love.load()
  math.randomseed(os.time())

  love.window.setTitle("Breakout")

  love.graphics.setFont(retro_small)

  push:setupScreen(
    VIRTUAL_WIDTH,
    VIRTUAL_HEIGHT,
    WINDOW_WIDTH,
    WINDOW_HEIGHT,
    {
      vsync = true,
      fullscreen = false,
      resizable = true
    }
  )

  gStateMachine:change("start")

  love.keyboard.keysPressed = {}
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.update(dt)
  gStateMachine:update(dt)

  -- reset keys pressed
  love.keyboard.keysPressed = {}
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

function love.draw()
  push:apply("start")

  love.graphics.draw(
    Textures["bg"],
    0,
    0,
    0,
    VIRTUAL_WIDTH / (backgroundWidth - 1),
    VIRTUAL_HEIGHT / (backgroundHeight - 1)
  )

  gStateMachine:render()

  displayFPS()

  push:apply("end")
end
