--[[
NOTE* This file may not be used for anything *
GAME NAME HERE: 
File: PLAYER -- 'Class'/Table for players

NOTES -> Currently simplified for testing purposes

]]--

local Player = {}
Player.__index = Player

function Player:create(num, image)
	local player = {}
	--will add variables to determine 1st or 2nd player.
	player.p = num -- determines whether to set to player 1 controls or player 2 controls. 
	
	-- MIGHT BE REMOVED
	player.x = 0 -- determined by stage(?)  
	player.y = 0 -- ''
	player.rot = 0 -- default
	player.scale_x = 0
	player.scale_y = 0

	player.img = love.graphics.newImage(image)
	player.width, player.height = player.img:getDimensions()
	
	--physics values
	player.ground = player.y
    -- what the player considers as the ground 
    -- could be changed to simply be determined by the platforms/stage

	player.mov_spd = 200 -- default
	player.jump_spd = 0 -- starting jump spd (y_velocity)
	player.jump_hgt = -300 -- max distance from orginal takeoff platform
	player.gravity = -500 -- individual gravity
	
	player.on_platform = true
	
	--draws player
	function player:draw()
		love.graphics.draw(player.img, player.x, player.y, player.rot, player.scale_x, player.scale_y)
	end 
	
	--checks if player is moving -- separate from jumping function in case of key conflicts == no diagonal jumping
	--See if there is a way to make more adaptable to moving on a platform
	function player:move()
        if player.on_platform == false then
            return
        end

		if player.p == 1 then
			if love.keyboard.isDown('a') then
				player.x = player.x - player.mov_spd
			elseif love.keyboard.isDown('d') then
				player.x = player.x + player.mov_spd
			end	
		elseif player.p == 2 then
			if love.keyboard.isDown('j') then 
				player.x = player.x - player.mov_spd
			elseif love.keyboard.isDown('l') then
				player.x = player.x + player.mov_spd
			end
		end
	end
	--Jumping
	--See comment for moving (I want to make it relative to platform position)
	function player:jump(dt)
        if player.on_platform == false then
            return
        end

		if player.jump_spd == 0 then 
			player.jump_spd = player.jump_hgt
		end
        -- more realistic physics - can't change midair?
        -- need to wait for collision and then can move again
        -- OORRRR in move can require to be on platform to go left/right
        -- also should be on platform to jump - can't jump on air
	end
	
	
	
	
	
end


return Player
