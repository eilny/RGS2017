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
	player.x = (g_Width / 3)   
	player.y = (g_Height /4) 
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
	
	player.on_platform = true
	
	--determines values for player 2
	if player.p == 2 then
		player.left = "j"
		player.right = "l"
		player.up = "i"
		player.down = "k"
		
		player.x =  (g_Width)*(3/4)
	end
	
	--draws player
	function player:draw()
		love.graphics.draw(player.img, player.x, player.y - player.height, player.rot, player.scale_x, player.scale_y)
	end 
	
	--checks if player is moving -- separate from jumping function in case of key conflicts == no diagonal jumping
	--See if there is a way to make more adaptable to moving on a platform
	function player:move(dt)
        -- if player.on_platform == false then
            -- return
        -- end

		if love.keyboard.isDown(player.left) then
			player.x = player.x - (player.mov_spd*dt)
		elseif love.keyboard.isDown(player.right) then
			player.x = player.x + (player.mov_spd*dt)
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
		--[[I was thinking that it would be moving and jumping only on plat]]
	end
	--[[
	player-platform detectors
	]]--
	-- function player:plat_coll(platfm)
		-- for i = 1, #platfm do
			-- if player.x + .9*player.width >= platfm[i].x and player.x + .1*player.width <= platfm[i].x + platfm.width and player.y <= platfm[i].y  then
				-- player.ground = platfm[i].y
				-- player.on_platform = true
			-- else
				-- player.ground = love.graphics.getHeight()
				-- player.on_platform = false
			-- end
		-- end
	-- end
	
	
	-- returning local variable
	return player
	
end


return Player
