--[[
NOTE* This file may not be used for anything *
GAME NAME HERE: 
File: PLAYER -- 'Class'/Table for players

NOTES -> Currently simplified for testing purposes

]]--

Class = require "hump.class"
Player = Class{}


function Player:init(num, img_file)	
	self.p = num -- determines whether to set to player 1 controls or player 2 controls. 
	
	
	--Default to player 1 values
	--Player controls 
	self.left = "a"
	self.right = "d"
	self.up = "w"
	self.down = "s"
	
	
	-- MIGHT BE REMOVED
	self.x = (g_Width / 5)   
	self.y = (g_Height /2) 
	self.rot = 0 -- default
	self.scale_x = 1
	self.scale_y = 1

	self.img = love.graphics.newImage(img_file)
	self.width, self.height = self.img:getDimensions()
	
	--physics values
	self.ground = self.y
    -- what the player considers as the ground 
    -- could be changed to simply be determined by the platforms/stage

	self.mov_spd = 200 -- default
	self.jump_spd = 0 -- starting jump spd (y_velocity)
	self.jump_hgt = -300 -- max distance from orginal takeoff platform
	self.gravity = -500 -- individual gravity
	
	self.on_platform = false --will be removed?
	self.platform = nil
	
	--determines values for player 2
	if self.p == 2 then
		self.left = "j"
		self.right = "l"
		self.up = "i"
		self.down = "k"
		
		self.x =  (g_Width)*(4/5)
	end
end
	
--draws player
function Player:draw()
	love.graphics.draw(self.img, self.x, self.y - self.height, self.rot, self.scale_x, self.scale_y)
end 
	
--checks if player is moving -- separate from jumping function in case of key conflicts == no diagonal jumping
--See if there is a way to make more adaptable to moving on a platform
function Player:control(dt)
    -- if player.on_platform == false then
        -- return
    -- end
	if love.keyboard.isDown(self.left) and self.x > 0 then
		self.x = self.x - (self.mov_spd*dt)
	elseif love.keyboard.isDown(self.right) and self.x + self.width < love.graphics.getWidth()  then
		self.x = self.x + (self.mov_spd*dt)
	end	

	if love.keyboard.isDown(self.up) then
		if self.on_platform == true  and self.jump_spd == 0 then
			self.jump_spd = self.jump_hgt
			self.on_platform = false
			self.platform = nil
		end
    end
	
	if self.platform ~= nil then 
		if self.x + (self.width*.9) >= self.platform.x and self.x + (self.width*.1) <= self.platform.x + self.platform.width then
            if self.y <= self.platform.y then
                self.ground = self.platform.y
                if self.y == self.platform.y then
                    self.on_platform = true
                end
            end
		else 
			self.ground = love.graphics.getHeight()
			self.on_platform = false
			self.platform = nil
		end
	end
	if self.on_platform then
		self.platform.dropping = true
		self.y = self.platform.y
	end
end
--Jumping(merged in control)
--See comment for moving (I want to make it relative to platform position)
--function player:jump(dt)
	

    -- more realistic physics - can't change midair?
    -- need to wait for collision and then can move again
    -- OORRRR in move can require to be on platform to go left/right
    -- also should be on platform to jump - can't jump on air
	--[[I was thinking that it would be moving and jumping only on plat]]
--end



--Controls player physics
function Player:physics(dt)
	if self.jump_spd ~= 0 or self.on_platform == false then
		self.y = self.y + (self.jump_spd * dt)
		self.jump_spd = self.jump_spd - (self.gravity * dt) 
		
	end
	if self.y > self.ground then 
		self.jump_spd = 0
		self.y = self.ground 
	end
end

