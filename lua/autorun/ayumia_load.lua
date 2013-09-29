if SERVER then 
	-- Clientside Files >
	AddCSLuaFile( )
	AddCSLuaFile( "core/client/cl_VersionMgr.lua" )
	AddCSLuaFile( "rpg/client/cl_init.lua" )
	AddCSLuaFile( "rpg/client/derma.lua" )
end

if CLIENT then 
	-- Clientside Includes >
	include( 'core/client/cl_VersionMgr.lua' )
	include( 'rpg/client/cl_init.lua' )
	include( 'rpg/client/Derma.lua' )
end

if SERVER then -- Serverside Includes >
	include( 'core/server/sv_VersionMgr.lua' )
	include( 'rpg/server/init.lua' )
	include( 'rpg/server/db.lua' )
end

if !SERVER and !CLIENT then 
	-- Shared includes >
end

if CLIENT then 
	-- Clientside Init Calls >
	VerCheckCL( )
end

if SERVER then 
	-- Serverside Init Calls >
	VerCheckSV( )
	InitSV( )
end
