if SERVER then
	-- Clientside files --
	AddCSLuaFile("autorun/arpg_init.lua")
	AddCSLuaFile("rpg/client/cl_init.lua")
end

-- Shared includes

if CLIENT then
	-- Client specific includes
end

if SERVER then
	-- Server includes --
	include("rpg/server/init.lua")
	
	timer.Simple( 2, ServerInit )
end