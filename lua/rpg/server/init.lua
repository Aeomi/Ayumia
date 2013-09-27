Adb = { }

function PrepareDirectory( path )
	MsgC( Color( 75, 100, 225), "[ Adb ] Directory '"..path.."' does not exist! Creating it for you...\n" )
	file.CreateDir( path )
	file.Write( path.."/direxist.txt" )
end

function PrepareDirectories( )
	if file.Read( "arpg/db/id/direxist.txt" ) != nil then
		return true
	end
	if file.Read( "arpg/direxist.txt" ) == nil then
		PrepareDirectory( "arpg" )
		PrepareDirectory( "arpg/db" )
		PrepareDirectory( "arpg/db/id" )
	elseif file.Read( "arpg/db/direxist.txt" ) == nil then
		PrepareDirectory( "arpg/db" )
		PrepareDirectory( "arpg/db/id" )
	else
		PrepareDirectory( "arpg/db/id" )
	end
	return true
end

function ServerInit( )
	MsgC( Color(75, 100, 225), "[ Adb ] Checking file system...\n" )
	if PrepareDirectories( ) then
		MsgC( Color(75, 100, 225), "[ Adb ] File system correctly installed.\n" )
	end
end

hook.Add( "PlayerSpawn", "PlySetUp", function( ply )
	local SID = ply:SteamID( )
	
	if SID == "BOT" then
		MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: Bot - ignoring\n" )
	elseif tonumber( SID ) != nil then
		MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: nil(???) - ignoring\n" )
	else
		local ID = string.sub( SID, 11, 18 )
		if Adb[ ID ] == nil then
			if file.Read( "arpg/db/id/".. ID ) == nil then
				MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: Ply - registering\n" )
				local SetUpDef = { name="n/a", mny=100 } 
				Adb[ ID ] = SetUpDef
				SaveID( ID )
			end
		end	
	end
end )