function GenerateQuads(atlas, tilewidth, tileheight)
  local sheetWidth = atlas:getWidth() / tilewidth
  local sheetHeight = atlas:getHeight() / tileheight

  local sheetCounter = 1
  local spritesheet = {}

  for y = 0, sheetHeight - 1 do
    for x = 0, sheetWidth - 1 do
      spritesheet[sheetCounter] =
        love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
      sheetCounter = sheetCounter + 1
    end
  end

  return spritesheet
end

function GenerateQuadsBricks(atlas)
  return GenerateQuads(atlas, 54, 22)
end

function GenerateQuadsPaddles(atlas)
  local x = 0
  local y = 0

  local h = 30

  local counter = 1
  local quads = {}

  for i = 0, 7 do
    -- smallest
    quads[counter] = love.graphics.newQuad(x, y, 58, h, atlas:getDimensions())
    counter = counter + 1
    -- medium
    quads[counter] = love.graphics.newQuad(x + 58, y, 90, h, atlas:getDimensions())
    counter = counter + 1
    -- large
    quads[counter] = love.graphics.newQuad(x + 58 + 90, y, 128, h, atlas:getDimensions())
    counter = counter + 1
    -- huge
    quads[counter] = love.graphics.newQuad(x + 58 + 90 + 128, y, 176, h, atlas:getDimensions())
    counter = counter + 1

    -- prepare X and Y for the next set of paddles
    x = 0
    y = y + h
  end

  return quads
end

function GenerateQuadsBalls(atlas)
  local x = 0
  local y = 0

  local h = 16
  local w = 16

  local counter = 1
  local quads = {}

  for i = 0, 3 do
    -- 1
    quads[counter] = love.graphics.newQuad(x, y, w, h, atlas:getDimensions())
    counter = counter + 1
    -- 2
    quads[counter] = love.graphics.newQuad(x + w, y, w, h, atlas:getDimensions())
    counter = counter + 1
    -- 3
    quads[counter] = love.graphics.newQuad(x + w + w, y, w, h, atlas:getDimensions())
    counter = counter + 1
    x = 0
    y = y + h
  end

  return quads
end

function table.slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced + 1] = tbl[i]
  end

  return sliced
end
