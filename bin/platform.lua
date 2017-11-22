--[[
NOTE* This file may not be used for anything *
GAME NAME HERE: 
File: PLATFORM --'Class'/Table for individual platforms
]]--

--import player for player collision detection
local Player = require "player"

local Platform = {}
Platform.__index = Platform 


function Platform:create(img_file, pos_x, pos_y)
	local platform = {}
	
	platform.img = love.graphics.newImage(img_file)
	
	platform.x = pos_x
	platform.y = pos_y
	platform.width, platform.height = platform.img:getDimensions()
	platform.on_screen = true
	-- UNDETERMINED VARIABLES (MAY BE IMPLEMENTED OR DELETED)
		--(Variable assignments may be needed in parameters)
	--Mainly used for drawing
	platform.rotation = rot 
	platform.scale_x = 1
	platform.scale_y = 1
	
	--Mainly used for physics
	platform.spd_x = 0 -- CAN DELETE
	platform.spd_y = 1 -- CAN DELETE
	--]]--
	function platform:draw()
		love.graphics.draw(platform.img, platform.x, platform.y, platform.rotation, platform.scale_x, platform.scale_y) --Will finish parameters if needed
	end
	
	function platform:drop(dt)
		platform.x = platform.x + ((platform.spd_x)*dt)
		platform.y = platform.y + ((platform.spd_y)*dt)
	end
	
	--more functions can go here
	function platform:scale(x, y)
		platform.scale_x = platform.scale_x + x
		platform.scale_y = platform.scale_y + y
	end 
	
	function platform:rotate(degree, direction)  -- may add speed for rotation
		for i = 0, degree do
			if direction == "cw" then 
				platform.rotation = platform.rotation + 1
			elseif direction == "ccw" then
				platform.rotation = platform.rotation - 1
			end
		end
	end

	function platform:coll_player(player, dt)
        --not on a platform OR (player platform is not empty and is this platform)
		if player.on_platform == false or (player.platform ~= nil and player.platform == platform) then
			if player.x + (.9*player.width) >= platform.x and player.x + (.1*player.width) <= platform.x + platform.width and player.y <= platform.y then
				player.ground = platform.y
				player.on_platform = true
				player.platform = platform 
			end
		end
        if platform.y < player.ground and player.y <= platform.y then 
            player.ground = platform.y
            player.on_platform = true
            player.platform = platform 
        end
	end


    --[[
    --if player onplat or if has no plat or if player.plat ~= this plat
    --  yes, stationary on a platform, can return
    --if player has plat
    --  if player plat ~= this plat
    --      if player within x bounds
    --          if player y < plat y
    --              if player ground < plat y
    --                  player ground = plat y, player onplat = true, player plat = plat
    --else not on platform or this plat is player plat
    --  if player within x bounds
    --      if player y above plat y
    --          player ground = plat y, player onplat = true, player plat = plat
    --]]

	--[[
		note: if the platforms will drop, then isn't it better if the players had the collider and didn't record a platform?
	]]

	--function
	
    function platform:player_collide(player, dt)
        --[[
        --if player.onplat
        --  return
        --if player.plat == this plat
        --  return -- do we need to do anything else?
        --if player within x bounds
        --  if player y < plat y
        --      if player no plat OR plat y < player ground
        --          player gound = plat y
        --          player plat = plat
        --]]
        if player.on_platform == true then
            --no collision; they are standing on a platform
            return
        end
        if player.platform ~= nil then
            if player.platform == platform then
                --this is player's platform: anything to do?
                return
            end
            --else: not the player's platform
            if platform.y > player.ground then
                --player ground is above platform y
                return
            end
        end
        --either player has no platform or platform is above/equal player ground
        if player.x + (.9*player.width) >= platform.x and player.x + (.1*player.width) <= platform.x + platform.width then
            --within x bounds
            if player.y <= platform.y then
                --above/on platform
                if player.y == platform.y then
                    --if player y just equals plat y, we are on a plat
                    player.on_platform = true
                end
                --still in midair, but can assign ground and platform
                player.ground = platform.y
                player.platform = platform
            end
        end
    end
	
	
	--return local variable
	return platform

end


return Platform
