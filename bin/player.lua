--[[
NOTE* This file may not be used for anything *
GAME NAME HERE: 
File: PLAYER -- 'Class'/Table for players

NOTES -> Currently simplified for testing purposes

]]--

local Player = {}
Player.__index = Player


function Player:create(num, img_file)
	local player = {}
	
	
	player.p = num -- determines whether to set to player 1 controls or player 2 controls. 
	
	
	--Default to player 1 values
	--Player controls 
	player.left = "a"
	player.right = "d"
	player.up = "w"
	player.down = "s"
	
	
	-- MIGHT BE REMOVED
	player.x = (g_Width / 5)   
	player.y = (g_Height /2) 
	player.rot = 0 -- default
	player.scale_x = 1
	player.scale_y = 1

	player.img = love.graphics.newImage(img_file)
	player.width, player.height = player.img:getDimensions()
	
	--physics values
	player.ground = player.y
    -- what the player considers as the ground 
    -- could be changed to simply be determined by the platforms/stage

	player.mov_spd = 200 -- default
	player.jump_spd = 0 -- starting jump spd (y_velocity)
	player.jump_hgt = -300 -- max distance from orginal takeoff platform
	player.gravity = -500 -- individual gravity
	
	player.on_platform = false --will be removed?
	player.platform = nil
	
	--determines values for player 2
	if player.p == 2 then
		player.left = "j"
		player.right = "l"
		player.up = "i"
		player.down = "k"
		
		player.x =  (g_Width)*(4/5)
	end
	
	--draws player
	function player:draw()
		love.graphics.draw(player.img, player.x, player.y - player.height, player.rot, player.scale_x, player.scale_y)
	end 
	
	--checks if player is moving -- separate from jumping function in case of key conflicts == no diagonal jumping
	--See if there is a way to make more adaptable to moving on a platform
	function player:control(dt)
        -- if player.on_platform == false then
            -- return
        -- end
		if love.keyboard.isDown(player.left) and player.x > 0 then
			player.x = player.x - (player.mov_spd*dt)
		elseif love.keyboard.isDown(player.right) and player.x + player.width < love.graphics.getWidth()  then
			player.x = player.x + (player.mov_spd*dt)
		end	

		if love.keyboard.isDown(player.up) then
			if player.on_platform == true  and player.jump_spd == 0 then
				player.jump_spd = player.jump_hgt
				player.on_platform = false
			end
        end
		
		if player.platform ~= nil then 
			if player.x + (player.width) >= player.platform.x and player.x + (player.width) <= player.platform.x + player.platform.width and player.y <= player.platform.y then
				player.ground = player.platform.y
				player.on_platform = true
			else 
				player.ground = love.graphics.getHeight()
				player.on_platform = false
				player.platform = nil
			end
		end
		
		
		
	end
	--Jumping(merged in control)
	--See comment for moving (I want to make it relative to platform position)
	--function player:jump(dt)
		

        -- more realistic physics - can't change midair?
        -- need to wait for collision and then can move again
        -- OORRRR in move can require to be on platform to go left/right
        -- also should be on platform to jump - can't jump on air
		--[[I was thinking that it would be moving and jumping only on plat]]
	--end

	
	
	--Controls player physics
	function player:physics(dt)
		if player.jump_spd ~= 0 or player.on_platform == false then
			player.y = player.y + (player.jump_spd * dt)
			player.jump_spd = player.jump_spd - (player.gravity * dt) 
			
		end
		if player.y > player.ground then 
			player.jump_spd = 0
			player.y = player.ground 
		end
	end
	
	
	
	-- returning local variable
	return player
	
end

-- returning 'class object'
return Player
