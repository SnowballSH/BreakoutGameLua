Ball = Class {}

function Ball:init(skin)
  -- simple positional and dimensional variables
  self.width = 16
  self.height = 16

  self.dy = 0
  self.dx = 0

  self.skin = skin
end

function Ball:collides(target)
  if self.x > target.x + target.width or target.x > self.x + self.width then
    return false
  end

  if self.y > target.y + target.height or target.y > self.y + self.height then
    return false
  end

  return true
end

function Ball:reset()
  self.x = VIRTUAL_WIDTH / 2 - 2
  self.y = VIRTUAL_HEIGHT / 2 - 2
  self.dx = 0
  self.dy = 0
end

function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt

  -- allow ball to bounce off walls
  if self.x <= 0 then
    self.x = 0
    self.dx = -self.dx
  end

  if self.x >= VIRTUAL_WIDTH - self.width then
    self.x = VIRTUAL_WIDTH - self.width
    self.dx = -self.dx
  end

  if self.y <= 0 then
    self.y = 0
    self.dy = -self.dy
  end
end

function Ball:render()
  love.graphics.draw(Textures["ball"], gQuads["balls"][self.skin], self.x, self.y)
end
