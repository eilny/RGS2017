--[[
NOTE* This file may not be used for anything *
GAME NAME HERE: 
File: PLATFORM --'Class'/Table for individual platforms
]]--

--import player for player collision detection
local Player = require "player"

local Platform = {}
Platform.__index = Platform 


function Platform:create(pos_x, pos_y, wid, ht)
	local platform = {}
	
	platform.x = pos_x
	platform.y = pos_y
	platform.width = wid
	platform.height = ht
	--[[ UNDETERMINED VARIABLES (MAY BE IMPLEMENTED OR DELETED)
		(Variable assignments may be needed in parameters)
	--Mainly used for drawing
	platform.rotation = rot 
	platform.scale_x = x_size
	platform.scale_y = y_size
	platform.img = love.graphics.newImage("platform")
	--Mainly used for physics
	platform.spd_x = 0 -- CAN DELETE
	platform.spd_y = 0 -- CAN DELETE
	]]--
	function platform:draw()
		--love.graphics.draw(platform.img, platform.x, platform.y, platform.rotation, platform.scale_x, platform.scale_y) --Will finish parameters if needed
	end
	
	function platform:drop(x_spd, y_spd)
		platform.x = platform.x + x_spd
		platform.y = platform.y + y_spd
	end
	
	--[[more functions can go here
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
	
	]]--
	function platform:collision_player(player)
		if player.x 
	
	end

end


return Platform