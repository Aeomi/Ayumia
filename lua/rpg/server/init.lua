Adb = { } -- Use "Adb = Adb or { }" on released versions.

-- Precache net-lib messages here.
util.AddNetworkString( "ClientName" )

net.Receive( "ClientName", function( len, ply )
	print( "[ Adb ] Received new name from ".. ply:Nick( ) )
	local CurSteamID = ply:SteamID( )
	local NewName = net.ReadString( )
	if not NewName:match( "^[%a%d ]+$" ) then
	-- TODO: Remove Mallows Personality from the prints.
	--		 Use MsgC instead of print.
	--		 Use chat.AddText instead of ChatPrint.
	--		 Use 'not' or '!' instead of == nil
		local Blu = Color( 10, 150, 200 )
		local Wht = Color( 255, 255, 255 )
		MsgC( Color( 75, 100, 225 ), "[ Adb ] Potentially malicious name, dropping.\n" )
		ply:SendLua( "chat.AddText( Blu, '[ Adb ]', Wht, ' Name denied by Server, do not use invalid characters.' )"  )
	end
	if CurSteamID == "BOT" then
		MsgC( Color( 75, 100, 225 ), "[ Adb ] That's a bot! Ignoring.\n" )
	else
		local NumID = tonumber( string.sub( CurSteamID, 11, 18 ) )
		if Adb[ NumID ] == nil then
			MsgC( Color( 75, 100, 225 ), "[ Adb ] Unexpected error occured, aborting!\n" )
			return
		end
		if Adb[ NumID ].name == false then
			-- TODO: New character stuffs.
			--		 Umi is the term for charactar/avatar/( etc )
			--		 Aumi, AUmi, Umi... Names are up for discussion.
			--		 Your Umi ( Youme ) is your virtual self.
			MsgC( Color( 75, 100, 225 ), "[ Adb ] ".. ply:Nick( ) .." is undergoing Umi creation" )
			Adb[ NumID ].name = NewName
			WriteTableToID( NumID )
		else
			-- TODO: Pre-existing character, name change.
			-- 		 Variable for old name plis x3
			MsgC( Color( 75, 100, 225 ), "[ Adb ] ".. Adb[ NumID ].name .." has changed their name.\n" )
		end
	end
end )

function PrepareDirectory( path )
	MsgC( Color( 75, 100, 225 ), "[ Adb ] Directory '"..path.."' does not exist, creating it for you...\n" )
	file.CreateDir( path )
	file.Write( path.."/direxist.txt" )
end

function PrepareDirectories( )
	if file.Read( "ayumia/rpg/db/id/direxist.txt" ) != nil then
		return true
	end
	if file.Read( "ayumia/direxist.txt" ) == nil then
		PrepareDirectory( "ayumia" )
		PrepareDirectory( "ayumia/rpg" )
		PrepareDirectory( "ayumia/rpg/db" )
		PrepareDirectory( "ayumia/rpg/db/id" )
	elseif file.Read( "ayumia/rpg/direxist.txt" ) == nil then
		PrepareDirectory( "ayumia/rpg" )
		PrepareDirectory( "ayumia/rpg/db" )
		PrepareDirectory( "ayumia/rpg/db/id" )
	elseif file.Read( "ayumia/rpg/db/direxist.txt" ) == nil then
		PrepareDirectory( "ayumia/rpg/db" )
		PrepareDirectory( "ayumia/rpg/db/id" )
	else
		PrepareDirectory( "ayumia/rpg/db/id" )
	end
	return true
end

function ServerInit( )
	MsgC( Color( 75, 100, 225 ), "[ Adb ] Checking file system...\n" )
	if PrepareDirectories( ) then
		MsgC( Color( 75, 100, 225 ), "[ Adb ] File system correctly installed.\n" )
	end
end

hook.Add( "PlayerInitialSpawn", "IDHandling", function( ply )
	local sID = ply:SteamID( )
	
	if sID == "BOT" then
		MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: Bot - ignoring\n" )
	elseif tonumber( sID ) != nil then
		MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: Irregular SteamID string - ignoring\n" )
	else
		local ID = tonumber( string.sub( sID, 11, 18 ) )
		if Adb[ ID ] == nil then
			if file.Read( "ayumia/rpg/db/id/".. ID ..".txt" ) == nil then
				MsgC( Color( 75, 100, 225 ), "[ Adb ] Unregistered ID detected: Ply - registering\n" )
				Adb[ ID ] = { name = false }
				WriteTableToID( ID )
			else
				if ReadIDToAdb( ID ) == false then
					-- Version mismatch, corrupt file, or unknown error.
					-- TODO: Delete old id file, build new one.
					--       This will destroy the users old stats, so
					--       When destroying, move the old ID information
					--       to "ayumia/db/id/<idhere>-old.txt"
					--       so the admin or a version update tool can fix it.
				end
				
				if Adb[ ID ].name == false then
					-- New character needs creating before anything else.
					timer.Simple( 4, function( ) ply:ConCommand( "ayu_rpg_requestname" ) end )
				else
					local Blu = Color( 10, 150, 200 )
					local Wht = Color( 255, 255, 255 )
					ply:SendLua( "chat.AddText( Blu, '[ Adb ]', Wht, ' Thank you for logging in, '.. Adb[ ID ].name ..'.' )"  )
				end
			end
		end
	end
end )

-- TODO: A Single character shall be allowed per player
--		 F: Begin work on "ayumia/db/id/<ply-id>_old.txt". 
--		 F: Begin work on tool to find "old" IDs and patch them accordingly.
--		 T: At Version 5r: Begin work on clientside code.
--		 				T: Begin work on Name-"popup" if name is false ( See Line 57 )
--						F: Create basic derma panel for the Main Menu - Menu is called with F2 key ( Up for discussion )


