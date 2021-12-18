local T = {}
local back = {}

function T.load()
  back.image = love.graphics.newImage("Buttons/Left.png")
  back.x = 10
  back.y = 0
  back.w = back.image:getWidth()*.4
  back.h = back.image:getHeight()*.4
end

function T.update()
  if(love.mouse.isDown(1)) then
    local x,y = love.mouse.getPosition()
    if((x > back.x) and (x < (back.x + back.w))
      and (y > back.y) and (y < (back.y + back.h))) then
        --clicked = true
        state = 1
      end
    end
end

function T.draw()
  local w = 30
  local wIndent = 50
  local h = H/5
  local scale = 1.4
  love.graphics.draw(back.image, back.x, back.y, 0, .4, .4)
  love.graphics.print("Assets By:", w , h - 20, 0, 2.7, 2.7)
  love.graphics.print("axassets -- meteors", wIndent, h+30, 0, scale, scale)
  love.graphics.print("dos88 -- background music", wIndent, h+60, 0, scale, scale)
  love.graphics.print("faktory -- planets", wIndent, h+90, 0, scale, scale)
  love.graphics.print("enjl -- background image", wIndent, h+120, 0, scale, scale)
  love.graphics.print("lelex -- fire animation", wIndent, h+150, 0, scale, scale)
  love.graphics.print("creativk -- intro font", wIndent, h+180, 0, scale, scale)
  love.graphics.print("gooseninja -- sound effects", wIndent, h+210, 0, scale, scale)
  love.graphics.print("murkje -- sound effects", wIndent, h+240, 0, scale, scale)
  love.graphics.print("pixel-poem -- heart", wIndent, h+270, 0, scale, scale)
  love.graphics.print("dinvstudio -- game over background", wIndent, h+300, 0, scale, scale)
  love.graphics.print("class asset pack -- ship and buttons", wIndent, h+330, 0, scale, scale)
end

return T
