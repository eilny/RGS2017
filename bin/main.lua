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
--player = {}
stage = Stage:create()
player1 = Player:create(1, "purple.png")
player2 = Player:create(2, "orange.png")

--Useful Global Variables
screen_width = love.graphics.getWidth()
screen_height = love.graphics.getHeight()


--remove after testing
pressed = 'n/a' -- reads what key is pressed

--sets window size, imgs, and "classes"
function love.load()
	love.window.setTitle("GAME NAME")
	--love.window.setMode(1200, 700) -- moved to conf.lua
	
	
	-- --player stuff
	-- player.x = platform.x + (platform.width /2)
	-- player.y = platform.y
	-- -- player img
	-- player.img = love.graphics.newImage("purple.png")
	-- --player dimensions
	-- player.width, player.height = player.img:getDimensions()
	-- --for physics?
	-- player.on_platform = true
	-- -- movement speed
	-- player.speed = 200
	-- player.ground = player.y
	
	
	--Stage class test--
	stage:spawning_plat("platform.png", player1)
	stage:spawning_plat("platform.png", player2)
	
	
	
end

function love.update(dt)
	
	-- -- checks if player is on platform
	-- if player.x + .9*player.width >= platform.x and player.x + .1*player.width <= platform.x + platform.width and player.y <= platform.y  then
		-- player.ground = platform.y
		-- player.on_platform = true
	-- else
		-- player.ground = love.graphics.getHeight()
		-- player.on_platform = false
	-- end
	
	
	-- --key detection
	-- if love.keyboard.isDown('d') then
	-- --should add borders if needed
		-- player.x = player.x + (player.speed * dt)
	-- elseif love.keyboard.isDown('a') then
		-- player.x = player.x - (player.speed * dt)
	-- end
	-- --jump key
	-- if love.keyboard.isDown('w')then
		-- if player.y_velocity == 0 then
			-- player.y_velocity = player.jump_height
		-- end
	-- end
	
	
	
	-- --physics
	-- if player.y_velocity ~= 0 or player.on_platform == false then
		-- player.y = player.y + (player.y_velocity * dt)
		-- player.y_velocity = player.y_velocity - (player.gravity * dt)
	-- end
	-- -- controls collision
	-- if player.y > player.ground then
		-- player.y_velocity = 0
		-- player.y = player.ground
	-- end
	-- --console prints
	-- if player.ground ~= player.y then 
		-- print("Player ground: "..player.ground)
	-- end
	-- --console prints end
	
	--playing with the classes (can be removed if needed --just testing code--)
	stage:colliders(player1)
	player1:move(dt)
	player2:move(dt)
	
end

function love.draw()
	
	
	--Class drawing functions
	stage:draw()
	player1:draw()
	player2:draw()
	
	--print functions to read positions and keys
	love.graphics.printf("Pressed: "..pressed,900, 50, 500, center)
	love.graphics.printf("Player1.x: "..player1.x, 900, 315, 500, center)
	love.graphics.printf("Player1.y: "..player1.y, 900, 330, 500, center)	
	love.graphics.printf("Player2.x: "..player2.x, 900, 345, 500, center)
	love.graphics.printf("Player2.y: "..player2.y, 900, 360, 500, center)
	
	
end

--test functions
function love.keypressed(key)
	pressed = key
end

--test functions
function love.keyreleased(key) 
	pressed = 'n/a'

end
