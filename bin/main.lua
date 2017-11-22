--[[
GAME NAME HERE: 
Description: Platformer w/ 2 players
Objective: Last Survivor
File: Main--callback functions
]]--

--imported files

local Player = require "player"
local Stage = require "stage"

-- --Variable(tables)
--platform = {}
stage = Stage:create()
player1 = Player:create(1, "purple.png")
player2 = Player:create(2, "orange.png")


players = {}
players[1] = player1
players[2] = player2


--Useful Global Variables
screen_width = love.graphics.getWidth()
screen_height = love.graphics.getHeight()


--remove after testing
pressed = 'n/a' -- reads what key is pressed

--sets window size, imgs, and "classes"
function love.load()
	love.window.setTitle("GAME NAME")
	
	bg_img = love.graphics.newImage("background.jpg")
	
	--Stage class test--
	stage:spawning_plat("platform.png", players)
	
end

function love.update(dt)
	
	--playing with the classes (can be removed if needed --just testing code--)
	player1:control(dt)
	player2:control(dt)
	player1:physics(dt)
	player2:physics(dt)
	
	--Collision detection
	stage:colls(players, dt)
	
	stage:new_plat("platform.png")
end

function love.draw()
	
	love.graphics.draw(bg_img, 0, 0, 0, 1, 1)
	
	--Class drawing functions
	stage:draw()
	player1:draw()
	player2:draw()
	
	--print functions to read positions and keys
	love.graphics.printf("Pressed: "..pressed, 800, 50, 500, center)
	love.graphics.printf("Player1.x: "..player1.x, 800, 65, 500, center)
	love.graphics.printf("Player1.y: "..player1.y, 800, 80, 500, center)	
	love.graphics.printf("Player2.x: "..player2.x, 800, 95, 500, center)
	love.graphics.printf("Player2.y: "..player2.y, 800, 110, 500, center)
	love.graphics.printf("Player1.ground: "..player1.ground, 800, 125, 500, center)
	love.graphics.printf("Player2.ground: "..player2.ground, 800, 140, 500, center)
    if player1.on_platform == true then
        love.graphics.printf("Player1.on_platform: ".."true", 800, 155, 500, center)
    else
        love.graphics.printf("Player1.on_platform: ".."false", 800, 155, 500, center)
    end
    if player2.on_platform == true then
        love.graphics.printf("Player2.on_platform: ".."true", 800, 170, 500, center)
    else
        love.graphics.printf("Player2.on_platform: ".."false", 800, 170, 500, center)
    end
	
	
end


--test functions
function love.keypressed(key)
	pressed = key
	if key == 'escape' then 
		love.event.quit()
	end

end

--test functions
function love.keyreleased(key) 
	pressed = 'n/a'
end
