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
	function stage:spawning_plat(img)
		platfm[1] = Platform:create(img, (g_Width / 11), (g_Height /2))
		platfm[2] = Platform:create(img, ((10*g_Width) /11) - platfm[1].width , ((g_Height) / 2))
	
	end
	
	function stage:draw()
		for i = 1, #platfm do
			platfm[i]:draw()
		end 
	end
	
	function stage:collision(players)
		for i = 1, #players do 
			if players[i].platform ~= nil then
			players[i].platform:coll_player(players[i])
			else
				for j = 1, #platfm do 
					if players[i].platform ~= nil then
						break
					else
						platfm[j]:coll_player(players[i])
					end
				end
			end
		end
	end
	
	--return local variable
	return stage
	
end

return Stage

