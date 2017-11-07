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
	
	platform.img = love.graphics.newImage("platform")
	
	platform.x = pos_x
	platform.y = pos_y
	platform.width, platform.height = platform.img:getDimensions()
	platform.on_screen = true
	-- UNDETERMINED VARIABLES (MAY BE IMPLEMENTED OR DELETED)
		--(Variable assignments may be needed in parameters)
	--Mainly used for drawing
	platform.rotation = rot 
	platform.scale_x = x_size
	platform.scale_y = y_size
	
	--Mainly used for physics
	platform.spd_x = 0 -- CAN DELETE
	platform.spd_y = 0 -- CAN DELETE
	--]]--
	function platform:draw()
		--love.graphics.draw(platform.img, platform.x, platform.y, platform.rotation, platform.scale_x, platform.scale_y) --Will finish parameters if needed
	end
	
	function platform:drop(x_spd, y_spd, dt)
		platform.x = platform.x + (x_spd*dt)
		platform.y = platform.y + (y_spd*dt)
	end
	
	--more functions can go here
	function platform:scale(x, y)
		platform.scale_x = platform.scale_x + x
		platform.scale_y = platform.scale_y + y
	end 
	
	function platform:rotate(degree, direction)  -- may add speed for rotation
		change = 0
		for change, degree do
			if direction == "cw" then 
				platform.rotation = platform.rotation + 1
			elseif direction == "ccw" then
				platform.rotation = platform.rotation - 1
			end
		end
	end
	
	--]]--
	function platform:collision_player(player)
		if player.x + .9*player.width >= platform.x and player.x + .1*player.width <= platform.x + platform.width and player.y <= platform.y then
			player.ground = platform.y
			player.on_platform = true
		else
			player.ground = player.y
			player.on_platform = false
		end
	end
	
	function
	

end


return Platform