--[[
NOTE* This file may not be used for anything *
GAME NAME HERE: 
File: STAGE-- manages the stage platforms
]]--
require "platform"
Class = require "hump.class"

Stage = Class{}
platfm = {}

g_Width = love.graphics.getWidth()
g_Height = love.graphics.getHeight()

function Stage:init()
	self.min_plat = 4
	self.max_plat = 10
	
	self.is_full = false
	self.show_plat = true
	
	self.rot = 0
	self.scale = 0
	--will rework this function for easier manipulation
end

function Stage:spawning_plat(img, players)
	platfm[1] = Platform(img, (g_Width / 11), (g_Height /2))
	platfm[2] = Platform(img, ((10*g_Width) /11) - platfm[1].width , ((g_Height) / 2))
	
	for i, play in ipairs(players) do
        players[i].x = platfm[i].x + ((1/2)*platfm[i].width) - ((1/2)*players[i].width)
    end
end
	
function Stage:new_plat(img)
	i = table.getn(platfm) 
	if i < self.max_plat then
		i = table.getn(platfm) + 1
		math.randomseed( os.time() )
		new_x = math.random(10, (g_Width - platfm[1].width))
		new_y = math.random(100, (g_Height - 500))
		pic = love.graphics.newImage(img)
		wid, hgt = pic:getDimensions()
		while self.no_spwn(new_x , new_y, wid, hgt) == true do
			new_x = math.random(10, (g_Width - platfm[1].width))
			new_y = math.random(100, (g_Height - 100))
		end
		platfm[i]  =  Platform(img, new_x, new_y) 
	end
end
	
	
function Stage:draw()
	for i = 1, #platfm do
		platfm[i]:draw()
	end 
end

function Stage:colls(players, dt)
	for i, plat in ipairs(platfm) do 
        for j, play in ipairs(players) do
            plat:player_collide(play, dt)
		end
		if plat.dropping then
			plat:drop(dt)
		end
	end
end
	
function Stage:no_spwn(new_x, new_y, wid, hgt)
	for i, plat in ipairs(platfm) do
		if (new_x >= plat.x and new_x + wid <= plat.x + plat.width) or (new_y >= plat.y and new_y + hgt <= plat.y + plat.height) then
			return true
		end
	end
	return false
end
