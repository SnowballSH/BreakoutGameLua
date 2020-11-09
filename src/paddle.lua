Paddle = Class {}

function Paddle:init()
  -- start us off with no velocity
  self.dx = 0

  self.skin = math.random(1, 7)
  self.size = 3

  -- starting dimensions
  self.width = DIMS[self.size]
  self.height = 32

  self.x = VIRTUAL_WIDTH / 2 - DIMS[self.size] / 2

  self.y = VIRTUAL_HEIGHT - 64
end

function Paddle:update(dt)
  -- keyboard input
  if love.keyboard.isDown("left") then
    self.dx = -PADDLE_SPEED
  elseif love.keyboard.isDown("right") then
    self.dx = PADDLE_SPEED
  else
    self.dx = 0
  end

  if self.dx < 0 then
    self.x = math.max(0, self.x + self.dx * dt)
  else
    self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
  end
end

function Paddle:render()
  love.graphics.draw(Textures["paddle"], gQuads["paddles"][self.size + 4 * (self.skin - 1)], self.x, self.y)
end
