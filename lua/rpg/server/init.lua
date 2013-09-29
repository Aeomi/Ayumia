Adb = { }

-- Precache net-lib messages here.
util.AddNetworkString("clientName")

net.Receive( "clientName", function( len, ply )
	print( "[ Adb ] Received new name from " .. ply:Nick( ) )
	local CurrentSteamID = ply:SteamID( )
	local NewName = net.ReadString()
	if NewName:match( "^[%a%d ]+$" ) == nil then
		print("[ Adb ] Potentially malicious name, dropping it!")
		ply:ChatPrint( "I do wish you wouldn't do that!" )
	end
	if CurrentSteamID == "BOT" then
		print( "[ Adb ] That's a bot! Ignoring." )
	else
		local NumID = tonumber( string.sub( CurrentSteamID, 11, 18 ) )
		if Adb[ NumID ] == nil then
			print( "[ Adb ] Unexpected error occured! aborting!" )
			return
		end
		if Adb[ NumID ].name == false then
			-- TODO: New character stuffs.
			print( "[ Adb ] New character!" )
			Adb[ NumID ].name = NewName
			WriteTableToID( NumID )
		else
			-- TODO: Pre-existing character, name change.
			print( "[ Adb ] Character wanted to change name!" )
		end
	end
end)

function PrepareDirectory( path )
	MsgC( Color( 75, 100, 225), "[ Adb ] Directory '"..path.."' does not exist, creating it for you...\n" )
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

hook.Add( "PlayerInitialSpawn", "IDInitJoinHandling", function( ply )
	local S_ID = ply:SteamID( )
	
	if S_ID == "BOT" then
		MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: Bot - ignoring\n" )
	elseif tonumber( S_ID ) != nil then
		MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: Irregular SteamID string - ignoring\n" )
	else
		local ID = tonumber( string.sub( S_ID, 11, 18 ) )
		if Adb[ ID ] == nil then
			if file.Read( "arpg/db/id/".. ID ..".txt" ) == nil then
				MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: Ply - registering\n" )
				Adb[ ID ] = { name = false }
				WriteTableToID( ID )
			else
				if ReadIDToAdb( ID ) == false then
					-- Version mismatch, corrupt file, or unknown error.
					-- TODO: Delete old id file, build new one.
					--       This will destroy the users old stats, so
					--       When destroying, move the old ID information
					--       to "arpg/db/id/<idhere>-old.txt"
					--       so the admin or a version update tool can fix it.
				end
				
				if Adb[ ID ].name == false then
					-- New character needs creating before anything else. -- Deprecated TODO
					timer.Simple( 4, function( ) ply:ConCommand( "ayu_rpg_requestname" ) end )
				else
					ply:ChatPrint( "Hello again, " .. Adb[ ID ].name .. "!" )
				end
			end
		end
	end
end )

-- TODO: A Single character shall be allowed per player
--		 Begin work on "arpg/db/id/<ply-id>_old.txt".
--		 Begin work on tool to find "old" IDs and patch them accordingly.
--		 At Version 5r: Begin work on clientside code.
--		 				Begin work on Name-"popup" if name is false ( See Line 57 )
--						Create basic derma panel for the Main Menu - Menu is called with F2 key ( Up for discussion )


