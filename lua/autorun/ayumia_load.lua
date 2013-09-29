if SERVER then
	-- Clientside files --
	AddCSLuaFile( "autorun/arpg_init.lua" )
	AddCSLuaFile( "rpg/client/cl_init.lua" )
	AddCSLuaFile( "rpg/client/derma.lua" )
end

-- Shared includes

if CLIENT then
	-- Client specific includes
	include( "rpg/client/cl_init.lua" )
	include( "rpg/client/derma.lua" )
end

if SERVER then
	-- Server includes --
	include( "rpg/server/init.lua" )
	include( "rpg/server/db.lua" )
	
	ServerInit( )
end