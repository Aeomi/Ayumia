Adb = { }



function PrepareDirectory( path )
	MsgC( Color( 75, 100, 225), "[ Adb ] Directory '"..path.."' does not exist! Creating it for you..." )
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
	
function SaveID( IDToSave )
	local FileR = file.Read( "arpg/db/id/".. IDToSave ..".txt" )
	if FileR == nil then -- ID does not exist, create & save it
		MsgC( Color( 75, 100, 225 ), "[ Adb ] ID#".. IDToSave .." missing from database...\n" )
		if WriteIDFile( IDToSave ) then
			MsgC( Color( 75, 100, 225 ), "[ Adb ] Writing ID#".. IDToSave .." to database...\n" )
		else
			MsgC( Color( 75, 100, 225 ), "[ Adb ] Error: ID#".. IDToSave .." was not saved; could not append array to file.\n" )
		end
	else -- ID does exist, overwrite it
		if WriteIDFile( IDToSave ) then
			MsgC( Color( 75, 100, 225 ), "[ Adb ] ID#".. IDToSave .." is an existing ID; overwriting file.\n" )
		else 
			MsgC( Color( 75, 100, 225 ), "[ Adb ] Error: ID#".. IDToSave .." was not saved; could not append array to file.\n" )
		end
	end
end
 

function TblToString( IDToConv )
	local Str = ""
	for k, v in pairs( Adb[ IDToConv ] ) do
		Str = Str .. k .."=".. v
	end
	return Str
end


function WriteIDFile( IDToWrite ) 
	local Str = TblToString( IDToWrite ) 
	if Str == nil then
		return false
	elseif type( Str ) == "string" then
		print( Str )
		file.Write( "arpg/db/id/".. IDToWrite ..".txt", Str )
		return true
	end
end


function FileIDRead( IDToRead )
	FileContents = file.Read( "arpg/db/id/".. IDToRead ..".txt"  )
	return( FileContents )
end

function DeleteCheckFiles( )
	file.Delete( "arpg/direxist.txt" )
	file.Delete( "arpg/db/direxist.txt" )
	file.Delete( "arpg/db/id/direxist.txt" )
	MsgC( Color( 175, 100, 225 ), "[ Adb ] Directory check files were deleted successfully.\n" )
end

function ServerInit( )

	timer.Simple( 1, function( )
		MsgC( Color( 75, 100, 225 ), "[ Adb ] Filesystem check in progress...\n" )
		timer.Simple( 2, function( )
			MsgC( Color(75, 100, 225), "[ Adb ] Checking folder structure..." )
			PrepareDirectories()
			MsgC( Color(75, 100, 225), "[ Adb ] Everything seems to be in order!" )
		end )
	end )

end






-- Well fuck it, here's your change. F u conflict


if SERVER then
	
	ServerInit( )
	
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
end )
