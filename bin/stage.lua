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
	function stage:spawning_plat(img, players)
		platfm[1] = Platform:create(img, (g_Width / 11), (g_Height /2))
		platfm[2] = Platform:create(img, ((10*g_Width) /11) - platfm[1].width , ((g_Height) / 2))
		
		for i, play in ipairs(players) do
            players[i].x = platfm[i].x + ((1/2)*platfm[i].width) - ((1/2)*players[i].width)
        end
	end
	
	function stage:new_plat(img)
		i = table.getn(platfm) + 1
		platfm[i]  =  Platform:create(img, math.random(0, g_Width), math.random(0, g_Height)) 
	end
	
	function stage:draw()
		for i = 1, #platfm do
			platfm[i]:draw()
		end 
	end
	
	function stage:colls(players)
		for i, plat in ipairs(platfm) do 
            for j, play in ipairs(players) do
				if play.platform == nil then
					plat:coll_player(play)
				end
			end
		end
        for i, play in ipairs(players) do
            if (play.on_platform == false) then
                play.ground = g_Height
            end
        end
	end
	
	
	--return local variable
	return stage
	
end

return Stage

