require("isTouching")
earth = {}
mars = {}
moon = {}
bullet = {}
--local numBullets = 1
local time = 0
local planets = {}
drawBullet = false
planets.earth = love.graphics.newImage("AssetJam/earth.png")
planets.mars = love.graphics.newImage("AssetJam/mars.png")
planets.moon = love.graphics.newImage("AssetJam/moon.png")
local numMeteors = 6

function spawnBullet()
  shoot = {}
  --bullet = {}
  --bullet.x = x
  --bullet.y = y
  --bullet.w = w
  --bullet.h = h
  --bullet.dy = dy
  --table.insert(bullets, bullet)

  function shoot.draw()
    love.graphics.setColor(.7, 0, 0)
    love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.w, bullet.h)
    love.graphics.setColor(1,1,1,1)
  end
end

planetsDy = 30
function makeEarth()
  for i = 1, 3 do
    earth[i] = {}
    earth[i].x = love.math.random(0, W-40)
    --these are in for loops because if not they will draw all earths in the same spot
    earth[i].y = love.math.random(0, H-100)
  end
end
function makeMars()
  for i = 1, 3 do
    mars[i] = {}
    mars[i].x = love.math.random(0, W-40)
    mars[i].y = love.math.random(0, H-100)
  end
end
function makeMoon()
  for i = 1, 3 do
    moon[i] = {}
    moon[i].x = love.math.random(0, W-40)
    moon[i].y = love.math.random(0, H-100)
  end
end

function makeMeteors()
  meteor = {}
  for i = 1, numMeteors do
    meteor[i] = {}
    meteor[i].image = love.graphics.newImage("images/meteor.png")
    meteor[i].x = love.math.random(0, W-40)
    meteor[i].y = love.math.random(0, 100)
    meteor[i].w = (meteor[i].image:getWidth())
    meteor[i].h = (meteor[i].image:getHeight())
    meteor[i].dy = 200
  end
  function meteor.update(dt)
    for i = 1, #meteor do
      meteor[i].y = meteor[i].y + (meteor[i].dy*dt)
      --redraws them at the top when they reach too far down
      if(meteor[i].y > (ship.y + 500)) then
        meteor[i].y = ship.y - 400
        meteor[i].x = love.math.random(0, W-20)
        meteor[i].dy = love.math.random(100, 300) -- random speed
      end
    end
  end
  return meteor
end

function makePowerup()
  powerup = {}
  for i = 1, 3 do
    powerup[i] = {}
    powerup[i].image = love.graphics.newImage("images/powerup_icon.png")
    powerup[i].x = love.math.random(0, W-40)
    powerup[i].y = love.math.random(0, 400)
    powerup[i].w = (powerup[i].image:getWidth())
    powerup[i].h = (powerup[i].image:getHeight())
    powerup[i].dy = 200
  end
  function powerup.update(dt)
    for i = 1, #powerup do
      powerup[i].y = powerup[i].y + (powerup[i].dy*dt)
      --redraws them at the top when they reach too far down
      if(powerup[i].y > (ship.y + 500)) then
        powerup[i].y = ship.y - 500
        powerup[i].x = love.math.random(0, W-20)
        powerup[i].dy = love.math.random(100, 300) -- random speed
      end
    end
  end
  return powerup
end

function draw_planets()
  for i = 1, 3 do
    love.graphics.draw(planets.earth, earth[i].x, earth[i].y, 0, 2, 2)
    love.graphics.draw(planets.mars, mars[i].x, mars[i].y, 0, 2, 2)
    love.graphics.draw(planets.moon, moon[i].x, moon[i].y, 0, 2, 2)
  end
end

function updatePlanets(dt)
  for i = 1, #earth do
    earth[i].y = earth[i].y - (planetsDy*dt)
    if(earth[i].y > (ship.y + 500)) then
      earth[i].y = ship.y - 400
      earth[i].x = love.math.random(0, W-20)
    end
  end

  for i = 1, #mars do
    mars[i].y = mars[i].y - (planetsDy*dt)
    if(mars[i].y > (ship.y + 500)) then
      mars[i].y = ship.y - 400
      mars[i].x = love.math.random(0, W-20)
    end
  end

  for i = 1, #moon do
    moon[i].y = moon[i].y - (planetsDy*dt)
    if(moon[i].y > (ship.y + 500)) then
      moon[i].y = ship.y - 500
      moon[i].x = love.math.random(0, W-20)
    end
  end
end
  function makeShip(dx, dy)
    ship = {}
    ship.image = love.graphics.newImage("Spaceship-No-Fire-lil.png")
    ship.dx = dx
    ship.dy = dy
    ship.x = W-300
    ship.y = H - 100
    ship.w = ship.image:getWidth()
    ship.h = ship.image:getHeight()
    return ship
  end
