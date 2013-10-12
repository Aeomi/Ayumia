-- TODO: Make a static Version updater that reads from; "addons/Arpg/ver.txt" 
--		 Make a shiny version message :3
--		 Make old Wiremod Style notification depicting version!


MsgC( Color( 10, 100, 200 ), "Ayumia is installed on this server!\n" )

function SendNewName( name )
	if name:match( "^[%a ]+$" ) != nil then
		net.Start( "ClientName" )
		net.WriteString( name )
		net.SendToServer( )
		return true
	else
		return false
	end
end