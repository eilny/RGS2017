--[[
NOTE* This file may not be used for anything *
GAME NAME HERE: 
File: PLATFORM --'Class'/Table for individual platforms
]]--

--import player for player collision detection

Class = require "hump.class"
player = require "player"

Platform = Class{}


function Platform:init(img_file, pos_x, pos_y)
	
	self.img = love.graphics.newImage(img_file)
	
	self.x = pos_x
	self.y = pos_y
	self.width, self.height = self.img:getDimensions()
	self.on_screen = true
	-- UNDETERMINED VARIABLES (MAY BE IMPLEMENTED OR DELETED)
		--(Variable assignments may be needed in parameters)
	--Mainly used for drawing
	self.rotation = rot 
	self.scale_x = 1
	self.scale_y = 1
	
	--Mainly used for physics
	self.spd_x = 0 -- CAN DELETE
	self.spd_y = 50 -- CAN DELETE
	self.dropping = false 
	--]]--
end

function Platform:draw()
	love.graphics.draw(self.img, self.x, self.y, self.rotation, self.scale_x, self.scale_y) --Will finish parameters if needed
end
	
function Platform:drop(dt)
	self.x = self.x + ((self.spd_x)*dt)
	self.y = self.y + ((self.spd_y)*dt)
end
	
--more functions can go here
function Platform:scale(x, y)
	self.scale_x = self.scale_x + x
	self.scale_y = self.scale_y + y
end 
	
function Platform:rotate(degree, direction)  -- may add speed for rotation
	for i = 0, degree do
		if direction == "cw" then 
			self.rotation = self.rotation + 1
		elseif direction == "ccw" then
			self.rotation = self.rotation - 1
		end
	end
end

function Platform:coll_player(player, dt)
    --not on a platform OR (player platform is not empty and is this platform)
	if player.on_platform == false or (player.platform ~= nil and player.platform == platform) then
		if player.x + (.9*player.width) >= self.x and player.x + (.1*player.width) <= self.x + self.width and player.y <= self.y then
			player.ground = self.y
			player.on_platform = true
			player.platform = self 
		end
	end
    if self.y < player.ground and player.y <= self.y then 
        player.ground = self.y
        player.on_platform = true
        player.platform = self 
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
	
function Platform:player_collide(player, dt)
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
        if player.platform == self then
            --this is player's platform: anything to do?
            return
        end
        --else: not the player's platform
        if self.y > player.ground then
            --player ground is above platform y
            return
        end
    end
    --either player has no platform or platform is above/equal player ground
    if player.x + (.9*player.width) >= self.x and player.x + (.1*player.width) <= self.x + self.width then
        --within x bounds
        if player.y <= self.y then
            --above/on platform
            if player.y == self.y then
                --if player y just equals plat y, we are on a plat
                player.on_platform = true
            end
            --still in midair, but can assign ground and platform
            player.ground = self.y
            player.platform = self
        end
    end
end
