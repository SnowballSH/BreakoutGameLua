LevelMaker = Class {}

function LevelMaker.createMap(level)
  local bricks = {}

  local numRows = math.random(2, 7)
  local numCols = math.random(7, 13)

  for y = 1, numRows do
    for x = 1, numCols do
      b =
        Brick(
        -- x-coordinate
        (x - 1) * 55 + 8 + -- the screen should have 8 pixels of padding; we can fit 13 cols + 16 pixels total
          (13 - numCols) * 55, -- left-side padding for when there are fewer than 13 columns
        -- y-coordinate
        y * 22 + 55
      )

      table.insert(bricks, b)
    end
  end

  return bricks
end
