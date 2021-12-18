
W = love.graphics.getWidth()
H = love.graphics.getHeight()
local T = {}
local background
local start = {}
local credits = {}
local mars, moon, earth, jupiter
local i, n, t, e, r, s, l, a
local iX, y
isMute = false
local music

function T.load()
  music = love.audio.newSource("DOS-88 - Far away.mp3", "stream")
  intro = love.audio.newSource("Race to Mars.mp3", "stream")
  background = love.graphics.newImage("background_1.png")
  earth = love.graphics.newImage("AssetJam/earth.png")
  mars = love.graphics.newImage("AssetJam/mars.png")
  moon = love.graphics.newImage("AssetJam/moon.png")
  jupiter = love.graphics.newImage("AssetJam/jupiter.png")
  start.image = love.graphics.newImage("start.png")
  credits.image = love.graphics.newImage("credits.png")
  i = love.graphics.newImage("Starglow_free/CK_StarGlowing_I.png")
  letterW = (i:getWidth()/2)-15
  letterH = i:getHeight()
  iX = W/13
  y = H/2 - 100
  n = love.graphics.newImage("Starglow_free/CK_StarGlowing_N.png")
  t = love.graphics.newImage("Starglow_free/CK_StarGlowing_T.png")
  e = love.graphics.newImage("Starglow_free/CK_StarGlowing_E.png")
  r = love.graphics.newImage("Starglow_free/CK_StarGlowing_R.png")
  s = love.graphics.newImage("Starglow_free/CK_StarGlowing_S.png")
  l = love.graphics.newImage("Starglow_free/CK_StarGlowing_L.png")
  a = love.graphics.newImage("Starglow_free/CK_StarGlowing_A.png")
  start.x = (W/2)-75
  start.y = (H/2)+30
  start.w = start.image:getWidth()/5
  start.h = start.image:getHeight()/5
  credits.x = (W/2)-75
  credits.y = (H/2) +75
  credits.w = credits.image:getWidth()/5
  credits.h = credits.image:getHeight()/5
  mute = {}
  mute.image = love.graphics.newImage("Buttons/Volume-Off.png")
  mute.x = W/2 + 90
  mute.y = (H/2)+30
  mute.w = mute.image:getWidth()*.27
  mute.h = mute.image:getHeight()*.27
end

function T.update()

  --if(love.mouse.isDown(1)) then
    function love.mousepressed(x, y, button, isTouch)
      if(button == 1) then

    local x,y = love.mouse.getPosition()
    if((x > start.x) and (x < (start.x + start.w))
      and (y > start.y) and (y < (start.y + start.h))) then
        --clicked = true
        state = 2
        intro:stop()
        if(isMute == false) then
          music:play()
        end
        love.audio.setVolume(1)
    elseif((x > mute.x) and (x < (mute.x + mute.w))
      and (y > mute.y) and (y < (mute.y + mute.h))) then
        --clicked = true
        isMute = not isMute
      --  love.graphics.setColor(.5, .5, .5, 1)
    elseif((x > credits.x) and (x < (credits.x + credits.w))
      and (y > credits.y) and (y < (credits.y + credits.h))) then
        state = 3
    end
    end
end
  if(isMute==true) then
    intro:pause()
    mute.image = love.graphics.newImage("Buttons/Volume-Up.png")
  else
    mute.image = love.graphics.newImage("Buttons/Volume-Off.png")
  end
end

function T.draw()
  --love.graphics.setColor(1, 1, 1, .2)
--  love.graphics.rectangle("fill", mute.x, mute.y, mute.w, mute.h)
--  love.graphics.setColor(1, 1, 1, 1)
  if(state == 1) and (isMute==false) then
    intro:play()
  end
  love.graphics.draw(background, 0, 0, 0, 3, 3)
  love.graphics.draw(earth, 50, 50, 0, 2, 2)
  love.graphics.draw(mars, W-80, H/2, 0, 2,2)
  love.graphics.draw(moon, W/3, H-70, 0, 2, 2)
  love.graphics.draw(jupiter, W/1.5, 67, 0, 2, 2)
  love.graphics.draw(i, iX, y)
  love.graphics.draw(n, iX + letterW, y)
  love.graphics.draw(t, iX + 2*letterW, y)
  love.graphics.draw(e, iX + 3*letterW, y)
  love.graphics.draw(r, iX + 4*letterW, y)
  love.graphics.draw(s, iX + 5*letterW, y)
  love.graphics.draw(t, iX + 6*letterW, y)
  love.graphics.draw(e, iX + 7*letterW, y)
  love.graphics.draw(l, iX + 8*letterW, y)
  love.graphics.draw(l, iX + 9*letterW, y)
  love.graphics.draw(a, iX + 10*letterW, y)
  love.graphics.draw(r, iX + 11*letterW, y)
  love.graphics.draw(start.image, start.x, start.y, 0, .2, .2)
  love.graphics.draw(mute.image, mute.x, mute.y, 0, .27, .27)
  love.graphics.draw(credits.image, credits.x, credits.y, 0, .2, .2)
  if(clicked == true) then
    love.graphics.print("Hi", W/2, H/2)
  end
end

return T
