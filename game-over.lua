local T = {}
require("buttons")
require("make-drawthings")
local background
function T.load()
  replay = makeButtons()
  font = love.graphics.newFont("BakbakOne-Regular.ttf")
  background = love.graphics.newImage("nebula03.png")
end

function T.update(dt)
  replay.update()
  if(redo == true) then
    redo = false
    state = 2
    ship.y = H
    for i = 1, #meteor do
      meteor[i].y = ship.y - 400
      meteor[i].y = meteor[i].y + meteor[i].dy*dt
    end
    score = 0
    translateY = 0
  end
end

function T.draw()
  love.graphics.draw(background, 0, 0, 0, .5, .5)
  love.graphics.draw(replay.replay, replay.replayX, replay.replayY, 0, .25, .25)
  love.graphics.setFont(font)
  love.graphics.print("Game Over! Your health ran out.", math.floor(W/3 - 40),
              math.floor(H/3), 0, 2, 2)
  love.graphics.print("Try Again", math.floor(W/2 -50),
              math.floor(H/2.5), 0, 2, 2)
end

return T
