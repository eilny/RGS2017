--[[
NOTE* This file may not be used for anything *
GAME NAME HERE: 
File: STAGE-- manages the stage platforms
]]--
local Platform = require "platform"


local Stage = {}
platfm = {}

g_Width = love.graphics.getWidth()
g_Height = love.graphics.getHeight()

function Stage:create()
	local stage = {}
	stage.min_plat = 4
	stage.max_plat = 6 
	
	stage.is_full = false
	stage.show_plat = true
	
	stage.rot = 0
	stage.scale = 0
	
	function stage:spawning_plat(img)
		platfm[1] = Platform:create(img, (g_Width / 6), (3*g_Height /4))
		platfm[2] = Platform:create(img, ((5*g_Width) /6), ((3*g_Height) / 4))
	end
	
	function stage:draw()
		for i = 1, #platfm do
			platfm[i]:draw()
		end 
	end
	
	function stage:plyer_coll(player)
		for i = 1, #platfm do 
			platfm[i]:collision_player(player)
		end
	end
	
	--return local variable
	return stage
	
end

return Stage

