local T = {}

W = love.graphics.getWidth()
H = love.graphics.getHeight()
require("make-drawthings")
require("isTouching")
require("buttons")
--local intro = require("intro-screen")
local fireFrames = {}
local currentFFrame -- fire frames
local earth = {}
local mars = {}
local moon = {}
local colorTime = 0
local t = 0
local camera_y_offset = 0
local camera_speed = 0
local translateY = 0
local changecolor = false
local isbulletTime = false
score = 0
local isPaused = false
local time = 0
local bulletTime = 0
local ship, sbox1, sbox2, mImage, buttonsImage

function T.load()
  --intro.load()
  knownObjects = {}
  ship = makeShip(200,140)
  sbox1 = makeHitBoxes()
  sbox2 = makeHitBoxes2()
  makeMeteors()
  bar1 = makeProgressBar(40, 10, 100, 20, 100, 100, {0,0,0.9},{1,1,1,.5})
  makePowerup()
  bullets = {}
  makePause()
  makeEarth()
  makeMars()
  makeMoon()
  background = love.graphics.newImage("background_1.png")
  heart = love.graphics.newImage("ui_heart_full.png")
  --sounds
  explode = love.audio.newSource("Explosion2.wav", "static")
  shot = love.audio.newSource("Laser_shoot8.wav", "static")
  loose = love.audio.newSource("Hit_Hurt.wav", "static")
  pUpSound = love.audio.newSource("Powerup3.wav", "static")
  backgroundY = 0
  backgroundX = 0
  --fire animation
  for i = 1, 4 do
    table.insert(fireFrames, love.graphics.newImage("fireAnimation/Fogo_".. i .. ".png"))
  end
  --meteor animation
  --  table.insert(meteorFrames, love.graphics.newImage("images/meteor.png"))
  --  table.insert(meteorFrames, love.graphics.newImage("images/flaming_meteor.png"))
  currentFFrame = 1
  currentMFrame = 1
end

function spawnBullet()
  local bullet = {}
  bullet.x = ship.x + 43
  bullet.y = ship.y - 10
  bullet.w = 10
  bullet.h = 10
  bullet.dy = 200
  table.insert(bullets, bullet)
end

function T.update(dt)
  --love.audio.pause(music)
  --fire animiation
  --  intro.update()
  currentFFrame = currentFFrame + 10 *dt
  if currentFFrame >= 5 then
    currentFFrame = 1
  end

  --checks if ship is touching a meteor
  local idx = isTouchingShip(meteor)
  if (idx > 0) then
    bar1.actualWidth = bar1.actualWidth - 5
    --moves meteor above the screen so it disappears
    meteor[idx].y = ship.y - 600
    --all color things have to do with making the ship flash when hit
    changecolor = true
    colorTime = colorTime + dt
  end
  if(changecolor == true) then
    colorTime = colorTime + dt
  end
  if(colorTime >= .15) then  -- red for .15 seconds then back to normal
    changecolor = false
    colorTime = 0
  end

  camera_x_offset = 0
  camera_y_offset = 0

  if (love.keyboard.isDown("down")) then
    ship.y = ship.y + (ship.dy*dt)
    sbox1.y = sbox1.y + (ship.dy*dt)
    sbox2.y = sbox2.y + (ship.dy*dt)
    for i = 1, #earth do
      earth[i].y = earth[i].y - (planetsDy*dt)
    end
    for i = 1, #mars do
      mars[i].y = mars[i].y - (planetsDy*dt)
    end
    for i = 1, #moon do
      moon[i].y = moon[i].y - (planetsDy*dt)
    end
    camera_y_offset = camera_y_offset + camera_speed
  end
  if (love.keyboard.isDown("up")) then
    ship.y = ship.y - ((ship.dy + 100)*dt)
    sbox1.y = sbox1.y - ((ship.dy + 100)*dt)
    sbox2.y = sbox2.y - ((ship.dy + 100)*dt)
  else
    ship.y = ship.y - (ship.dy*dt)
    sbox1.y = sbox1.y - (ship.dy*dt)
    sbox2.y = sbox2.y - (ship.dy*dt)
    camera_y_offset = camera_y_offset - camera_speed
  end

  if love.keyboard.isDown("left") then
    if(ship.x > (20)) then
      ship.x = ship.x - (ship.dx*dt)
      sbox1.x = sbox1.x - (ship.dx*dt)
      sbox2.x = sbox2.x - (ship.dx*dt)
    end
  end
  if love.keyboard.isDown("right") then
    if(ship.x < W - 120) then
      ship.x = ship.x + (ship.dx*dt)
      sbox1.x = sbox1.x + (ship.dx*dt)
      sbox2.x = sbox2.x + (ship.dx*dt)
    end
  end
  if love.keyboard.isDown("space") then
    spawnBullet()
    isbulletTime = true
    if(isMute == false) then
    shot:play()
    end
  end
  if(isbulletTime == true) then
    bulletTime = bulletTime + dt
  end

  for i, m in ipairs(bullets) do
    m.y = m.y - m.dy*dt
    if(bulletTime >= 2) then
      bullets[i] = nil
      bulletTime = 0
    end
  end
  local bIDX = isTouchingBullet(meteor)
  mIDX = isTouchingBullet(meteor)
  for i, m in ipairs(bullets) do
    if(bIDX > 0) then
      --bulletTime = bulletTime + dt
      meteor[bIDX].y = ship.y + 700
      bullets[i] = nil
      if(isMute == false) then
        explode:play()
      end
    end
  end

  ship.y = ship.y + camera_y_offset

  meteor.update(dt)
  pause.update(dt)
  time = time + dt
  if(isPaused == true) then
    buttons.update()
    shoot.update(dt)
  else
    score = score + dt
  end

  buttons.update(dt)
  bar1.update(dt)
  updatePlanets(dt)

  if(time > 20) then
    time = 0
    ship.dy = ship.dy + 20*dt
  end

  if(time >= 10) and (time <= 20) then
    drawPup = true
    powerup.update(dt)
  else
    drawPup = false
  end
  --checks if ship is touching powerup
  local pIDX = isTouchingShip(powerup)
  if(pIDX > 0) then
    if(isMute == false) and (drawPup == true)then
      pUpSound:play()
    end
    --moves powerup above the screen so it disappears
    powerup[pIDX].y = ship.y + 700
    if(bar1.actualWidth <= 95) and (drawPup == true)then
      --increases heart bar when you hit powerup
      bar1.actualWidth = bar1.actualWidth + 5
    end
  end
  t = t + dt

end -- ends update function

function T.draw()
  --camera thing
  translateY = H/2 - ship.y
  love.graphics.translate(0, translateY)

  --draws the background
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, 100 do
      love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
      love.graphics.draw(background, backgroundX + (background:getWidth()*i),
      backgroundY - (background:getHeight()*j))
    end
  end

  draw_planets()
  for i = 1, #meteor do
    love.graphics.draw(meteor[i].image, meteor[i].x, meteor[i].y, 0, 1.2, 1.2)
    -- love.graphics.setColor(1,0,1, .3)
    --love.graphics.rectangle("fill", meteor[i].x, meteor[i].y, meteor[i].w, meteor[i].h)
    -- love.graphics.setColor(1,1,1,1)
  end

  if(drawPup == true) then
    for i = 1, #powerup do
      love.graphics.draw(powerup[i].image, powerup[i].x, powerup[i].y, 0, 1.2, 1.2)
      --  love.graphics.setColor(1,0,1, .3)
      --  love.graphics.rectangle("fill", powerup[i].x, powerup[i].y, powerup[i].w, powerup[i].h)
      --  love.graphics.setColor(1,1,1,1)
    end
    drawPup = false
  end
  if(changecolor == true) then
    love.graphics.setColor(.9,0,0,1)
  else
    t = 0
    love.graphics.setColor(1,1,1,1)
  end
--  changecolor = false

  love.graphics.draw(ship.image, ship.x, ship.y, 0, 1.5, 1.5)
  --love.graphics.setColor(1,1,1,1)
  --love.graphics.setColor(1,0,1, .3)
  --love.graphics.rectangle("fill", sbox1.x, sbox1.y, sbox1.w, sbox1.h)
  --love.graphics.rectangle("fill", sbox2.x, sbox2.y, sbox2.w, sbox2.h)
  --love.graphics.setColor(1,1,1,1)
  love.graphics.draw(fireFrames[math.floor(currentFFrame)], ship.x + (ship.w/2)+6,
  ship.y + ship.h+13, .04, .15)
  for i, m in ipairs(bullets) do
    if(bullets[i] ~= nil) then
      love.graphics.setColor(.7, 0, 0)
      love.graphics.rectangle("fill", m.x, m.y, m.w, m.h)
      love.graphics.setColor(1,1,1,1)
    end
  end
  love.graphics.translate(0, -translateY)
  --things that dont move
  love.graphics.print(ship.dy , 40, 40)
  bar1.draw()
  --love.graphics.draw(mute.image, W - 75, pause.y, 0, .25, .25)
  love.graphics.print(math.floor(score), math.floor(W/2), 0, 0, 3, 3)
  love.graphics.draw(heart, 0, 5, 0, 2, 2)
  love.graphics.draw(pause.image, pause.x, pause.y, 0, .25, .25)
end

return T
