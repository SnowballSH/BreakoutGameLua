PlayState = Class {__includes = BaseState}

function PlayState:init()
  self.paddle = Paddle()
  self.pause = false

  self.ball = Ball(math.random(7))

  -- give ball random starting velocity
  self.ball.dx = (math.random(0, 1) == 0 and -1 or 1) * math.random(250, 450)
  self.ball.dy = math.random(-140, -160)

  -- give ball position in the center
  self.ball.x = VIRTUAL_WIDTH / 2 - 4
  self.ball.y = VIRTUAL_HEIGHT - 100

  self.bricks = LevelMaker.createMap()
end

function PlayState:update(dt)
  if self.paused then
    if love.keyboard.wasPressed("space") then
      self.paused = false
    else
      return
    end
  elseif love.keyboard.wasPressed("space") then
    self.paused = true
    return
  end

  -- update positions based on velocity
  self.paddle:update(dt)
  self.ball:update(dt)

  if self.ball:collides(self.paddle) then
    self.ball.dx = (math.random(0, 1) == 0 and -1 or 1) * math.random(250, 450)
    self.ball.dy = math.random(140, 160)
    self.ball.dy = -self.ball.dy

    if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
      self.ball.dx = -400
    elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
      self.ball.dx = 400
    end
  end

  for k, brick in pairs(self.bricks) do
    if brick.inPlay and self.ball:collides(brick) then
      brick:hit()
      if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
        -- right edge; only check if we're moving left
        -- flip x velocity and reset position outside of brick
        self.ball.dx = -self.ball.dx
        self.ball.x = brick.x - self.ball.width
      elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
        -- top edge if no X collisions, always check
        -- flip x velocity and reset position outside of brick
        self.ball.dx = -self.ball.dx
        self.ball.x = brick.x + 55
      elseif self.ball.y < brick.y then
        -- bottom edge if no X collisions or top collision, last possibility
        -- flip y velocity and reset position outside of brick
        self.ball.dy = -self.ball.dy
        self.ball.y = brick.y - self.ball.width
      else
        -- flip y velocity and reset position outside of brick
        self.ball.dy = -self.ball.dy
        self.ball.y = brick.y + 23
      end
      -- slightly scale the y velocity to speed up the game
      self.ball.dy = self.ball.dy * 1.02
    end
  end

  if love.keyboard.wasPressed("escape") then
    love.event.quit()
  end
end

function PlayState:render()
  for k, brick in pairs(self.bricks) do
    brick:render()
  end

  self.paddle:render()
  self.ball:render()

  love.graphics.setFont(retro_medium)
  love.graphics.print("dy: " .. tostring(self.ball.dy), 45, 45)
  love.graphics.print("dx: " .. tostring(self.ball.dx), 45, 75)

  -- pause text, if paused
  if self.paused then
    love.graphics.setFont(retro_big)
    love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, "center")
  end
end
