function WriteTableToID( ID )
	IDTable = Adb[ ID ]
	-- Incorrect ID or potentially malicious table names are a nono.
	if IDTable == nil then
		return false
	end
	-- Check for irregular (and possibly malicious) table values.
	for k, v in pairs( IDTable ) do
		if type( v ) == "string" and v:match( "[%a%d ]+" ) == nil then
			return false
		end
	end
	-- Compile the table into lua.
	local ResultStr = "ADB[ "..ID.." ] = {\n"
	for k, v in pairs( IDTable ) do
		if type( v ) == "number" then
			ResultStr = ResultStr..k.."="..v..",\n"
		elseif type( v ) == "string" then
			ResultStr = ResultStr..k.."=".."\""..v.."\""..",\n"
		end
	end
	-- Check if we actually did anything..
	local TestStr = string.sub( ResultStr, #ResultrStr-2 )
	if TestStr != ",\n" then
		return false
	end
	-- Clean off that bothersome ",\n" and finish up.
	ResultStr = string.sub( ResultStr, 1, #ResultStr-2 )
	ResultStr = ResultStr.."\n}"
	file.Write( "arpg/db/id/"..ID..".txt", ResultStr )
	return true
end

function ReadIDToAdb( ID )
	IDContents = file.Read( "arpg/db/id/"..ID..".txt" )
	if IDContents == nil or string.sub( IDContents, 1, 3 ) != "Adb" then
		return false
	end
	RunString( IDContents )
	return true
end