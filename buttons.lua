require("make-drawthings")
--change to game over state
local bar = {}
local isPaused = false
local actualWidth
function makeButtons()
  buttons = {}
  buttons.replay = love.graphics.newImage("buttons/Replay.png")
  buttons.replayH = buttons.replay:getHeight()*.25
  buttons.replayW = buttons.replay:getWidth()*.25
  buttons.replayX = W/2 -20
  buttons.replayY = H/2

  function buttons.update()
    if(love.mouse.isDown(1)) then
      local x,y = love.mouse.getPosition()
      if((x > buttons.replayX) and (x < (buttons.replayX + buttons.replayW))
      and (y > buttons.replayY) and (y < buttons.replayY + buttons.replayH)) then
        redo = true
      end
    end
  end
  redo = false
  return buttons
end--end makeButtons

function makeProgressBar(x, y, w, h, maxVal, currentVal, colorBar, colorBack)
  die = love.audio.newSource("loose.wav", "static")
  bar = {}
  bar.x = x
  bar.y = y
  bar.w = w
  bar.h = h
  bar.maxVal = maxVal
  bar.currentVal = currentVal
  bar.colorBar = colorBar
  bar.colorBack = colorBack
  bar.actualWidth = (bar.w-4) * (bar.currentVal/bar.maxVal)
  --  bar.text = text
  function bar.draw()
    love.graphics.setColor(bar.colorBack)
    love.graphics.rectangle("fill", bar.x, bar.y, bar.w, bar.h)
    love.graphics.setColor(bar.colorBar)
  --  actualWidth = (bar.w-4) * (bar.currentVal/bar.maxVal)
    love.graphics.rectangle("fill", bar.x+2, bar.y+2, bar.actualWidth, bar.h-4)
    love.graphics.setColor(1,1,1)
    --love.graphics.printf(bar.text,bar.x,bar.y,bar.w,"center")
  end
  function bar.update(dt)
    if(bar.actualWidth <= 0) then
      bar.actualWidth = (bar.w-4) * (bar.currentVal/bar.maxVal)
      state = 4
      if(isMute == false) then
        die:play()
      end
    end
    --  bar.currentVal = bar.maxVal
  end
  return bar
end

function makePause()
  pause = {}
  pause.image = love.graphics.newImage("buttons/Pause.png")
  pause.h = pause.image:getHeight()*.25
  pause.w = pause.image:getWidth()*.25
  pause.x = W - 35
  pause.y = 0
  function pause.update()
    function love.mousepressed(x, y, button, isTouch)
      if(button == 1) then
        local x,y = love.mouse.getPosition()
        if((x > pause.x) and (x < (pause.x + pause.w))
        and (y > pause.y) and (y < pause.y + pause.h)) then
          isPaused = not isPaused
        end -- check collision
      end -- check if
    end -- check mouse
    if(isPaused == true) then
      ship.dy = 0
      ship.dx = 0
      for i = 1, #meteor do
        meteor[i].dy = 0
      end
      for i = 1, #powerup do
        powerup[i].dy = 0
      end
      planetsDy = 0
      pause.image = love.graphics.newImage("Buttons/Right-Play.png")
    elseif(isPaused == false) then
      pause.image = love.graphics.newImage("Buttons/Pause.png")
      ship.dy = 140
      ship.dx = 200
      for i = 1, #meteor do
        meteor[i].dy = love.math.random(100, 300)
      end
      for i = 1, #powerup do
        powerup[i].dy = love.math.random(100, 300)
      end
      planetsDy = 30
    end -- is Paused
  end -- pause.update
  --isPaused = isPaused
  return pause
end -- makePause
