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
	--will rework this function for easier manipulation
	function stage:spawning_plat(img, player1)
		platfm[1] = Platform:create(img, (g_Width / 8), (g_Height /2))
		platfm[2] = Platform:create(img, ((7*g_Width) /8) - platfm[1].width , ((g_Height) / 2))
		-- if player.p == 1 then 
			-- platfm[1] = Platform:create(img, (g_Width / 8), (g_Height /4))
		-- elseif player.p == 2 then 
			-- platfm[2] = Platform:create(img, ((g_Width) /2) , ((g_Height) / 4))
		-- end
		-- if platfm == nil then
			-- platfm[1] = 
		-- end 
		
	end
	
	function stage:draw()
		for i = 1, #platfm do
			platfm[i]:draw()
		end 
	end
	
	function stage:collision(player1, player2)
		for i = 1, #platfm do 
			platfm[i]:coll_player(player1)
			platfm[i]:coll_player(player2)
		end
	end
	
	--return local variable
	return stage
	
end

return Stage

