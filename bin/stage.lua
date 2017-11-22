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
	stage.max_plat = 10
	
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
		i = table.getn(platfm) 
		if i < stage.max_plat then
			i = table.getn(platfm) + 1
			new_x = math.random(10, (g_Width - platfm[1].width))
			new_y = math.random(10, (g_Height - 100))
			pic = love.graphics.newImage(img)
			wid, hgt = pic:getDimensions()
			while stage:no_spwn(new_x , new_y, wid, hgt) == true do
				new_x = math.random(10, (g_Width - platfm[1].width))
				new_y = math.random(10, (g_Height - 100))
			end
			platfm[i]  =  Platform:create(img, new_x, new_y) 
		end
	end
	
	
	function stage:draw()
		for i = 1, #platfm do
			platfm[i]:draw()
		end 
	end
	
	function stage:colls(players, dt)
		for i, plat in ipairs(platfm) do 
            for j, play in ipairs(players) do
                --[[
				if play.platform == nil or play.on_platform == false then
					plat:coll_player(play, dt)
				end
                --]]
                plat:player_collide(play, dt)
			end
		end
	end
	
	function stage:no_spwn(new_x, new_y, wid, hgt)
		for i, plat in ipairs(platfm) do
			if (new_x >= plat.x and new_x + wid <= plat.x + plat.width) or (new_y >= plat.y and new_y + hgt <= plat.y + plat.height) then
				return true
			end
		end
		return false
	end
	
	
	--return local variable
	return stage
	
end

return Stage

