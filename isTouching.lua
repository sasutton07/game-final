--require("make-drawthings")
--require("main-state")
local sbox1 = {}
local sbox2 = {}
local b = {}

function makeHitBoxes()
  sbox1 = {}
  sbox1.x = ship.x + 37
  sbox1.w = 20
  sbox1.y = ship.y
  sbox1.h = ship.h+5
  return sbox1
end
function makeHitBoxes2()
  sbox2 = {}
  sbox2.x = ship.x
  sbox2.w = ship.w+30
  sbox2.y = ship.y + 45
  sbox2.h = 25
  return sbox2
end

function isTouchingShip(b)
  local alhs = sbox2.x
  local arhs = sbox2.x + sbox2.w
  local atop = sbox1.y
  local atop2 = sbox1.y+45
  local abottom = sbox1.y + sbox1.h

  for i = 1, #b do
    local blhs = b[i].x
    local brhs = b[i].x + b[i].w
    local btop = b[i].y
    local bbottom = b[i].y + b[i].h
    if((alhs <= brhs and arhs >= blhs) and (atop <= bbottom and abottom >= btop))
    then
      if((atop2 <= bbottom and abottom >= btop)) then

        if(b==meteor) then
          if(isMute == false) then
            loose:play()
          end
        end
        return i
      end
    end
  end
  return 0
end


function isTouchingBullet(b)
  for i, m in ipairs(bullets) do
    local alhs = m.x
    local arhs = m.x + m.w
    local atop = m.y
    local abottom = m.y + m.h

    bulletIndex = m
  for i = 1, #b do
    local blhs = b[i].x
    local brhs = b[i].x + b[i].w
    local btop = b[i].y
    local bbottom = b[i].y + b[i].h
    if((alhs <= brhs and arhs >= blhs) and (atop <= bbottom and abottom >= btop))
    then
    --b[i].dy = 0
      --ship.dy = 0
      --ship.dx = 0
    --  bulletIndex = m
      if(b==meteor) then
      --  loose:play()
      end
      return i
    end -- if end

  end -- for end
  end
  return 0
end -- function end
