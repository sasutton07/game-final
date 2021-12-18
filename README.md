# main
state = 1

local intro = require("intro-screen")
local main = require("main-state")
local credits = require("credits-screen")
local gameOver = require("game-over")

function love.load()
  intro.load()
  main.load()
  credits.load()
  gameOver.load()
end

function love.update(dt)

  if(state == 1) then
    intro.update()
  elseif(state == 2) then
    main.update(dt)
  elseif(state == 3) then
    credits.update()
  elseif(state == 4) then
    gameOver.update(dt)
  end
end

function love.draw()
  if(state == 1) then
    intro.draw()
  elseif(state == 2) then
    main.draw()
  elseif(state == 3) then
    credits.draw()
  elseif(state == 4) then
    gameOver.draw()
  end
end
