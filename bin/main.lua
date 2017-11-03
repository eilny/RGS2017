--[[
GAME NAME HERE: 
Description: Platformer w/ 2 players
Objective: Last Survivor
File: Main--callback functions
]]--

--Variable(tables)
platform = {}
player = {}

--remove after testing
pressed = 'n/a' -- reads what key is pressed

--sets window size, imgs, and "classes"
function love.load()
	love.window.setTitle("GAME NAME")
	love.window.setMode(1200, 700)
	
	platform.width = love.graphics.getWidth() / 3 --size of window width
	platform.height = love.graphics.getHeight() / 3-- size of window height
	
	platform.x = 100
	platform.y = platform.height + (platform.height /2)
	
	--player stuff
	player.x = platform.x + (platform.width /2)
	player.y = platform.y
	-- player img
	player.img = love.graphics.newImage("purple.png")
	--player dimensions
	player.width, player.height = player.img:getDimensions()
	--for physics?
	player.on_ground = true
	-- movement speed
	player.speed = 200
	player.ground = player.y
	
	player.y_velocity = 0
	
	player.jump_height = -300
	player.gravity = -500
end

function love.update(dt)

	-- checks if player is on platform
	if player.x + .9*player.width >= platform.x and player.x + .1*player.width <= platform.x + platform.width then
		player.ground = platform.y
		player.on_ground = true
	else
		player.ground = love.graphics.getHeight()
		player.on_ground = false
	end
	
	--key detection
	if love.keyboard.isDown('d') then
	--should add borders if needed
		player.x = player.x + (player.speed * dt)
	elseif love.keyboard.isDown('a') then
		player.x = player.x - (player.speed * dt)
	end
	--jump key
	if love.keyboard.isDown('w')then
		if player.y_velocity == 0 then
			player.y_velocity = player.jump_height
		end
	end
	
	
	
	--physics
	if player.y_velocity ~= 0 or player.on_ground == false then
		player.y = player.y + (player.y_velocity * dt)
		player.y_velocity = player.y_velocity - (player.gravity * dt)
	end
	-- controls collision
	if player.y > player.ground then
		player.y_velocity = 0
		player.y = player.ground
	end
end

function love.draw()
	love.graphics.setColor(255, 255, 255) --white
	--creates platform graphics
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
	-- draws player
	love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
	love.graphics.printf("Pressed: "..pressed,900, 100, 500, center)
	love.graphics.printf("Player.x: "..player.x,900, 115, 500, center)
	love.graphics.printf("Player.y: "..player.y,900, 130, 500, center)
	love.graphics.printf("Player.y_velocity: "..player.y_velocity,900, 145, 500, center)
	love.graphics.printf("Platform.x: "..platform.x,900, 160, 500, center)
	love.graphics.printf("Platform.y: "..platform.y,900, 175, 500, center)
end

function love.keypressed(key)
	pressed = key
end

function love.keyreleased(key) 
	pressed = 'n/a'

end
