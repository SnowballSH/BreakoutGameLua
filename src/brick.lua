Brick = Class {}

function Brick:init(x, y, color)
  color = color or 3
  self.tier = 2
  self.color = color

  self.x = x
  self.y = y
  self.width = 32
  self.height = 16

  self.inPlay = true
end

function Brick:hit()
  self.inPlay = false
end

function Brick:render()
  if self.inPlay then
    love.graphics.draw(Textures["block"], gQuads["bricks"][1 + (self.color - 1) + self.tier * 7], self.x, self.y)
  end
end
