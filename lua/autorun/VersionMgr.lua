Ayu = { }
Ayu.MyRev = 0
Ayu.GitRev = 0

-- TODO: Find a better solution to delay UpdateCheck Func! D':
--		 
function UpdateCheck( )
	timer.Simple( 1, function( ) 
		http.Fetch( "https://github.com/Aeomi/Ayumia", function( contents, size )
			local LRev = tonumber( file.Read( "addons/Ayumia/version.txt", true ) )
			local Rev = tonumber( string.match( contents, "history\"></span>\n%s*(%d+)\n%s*</span>" ) )
			if Rev and LRev >= Rev then
				MsgC( Color( 100, 50, 200 ), "[ Ayu/Core ] Ayumia is up to date;\nLatest Rev: ".. Rev .."\nLocal Rev: ".. LRev .."\n" )
			elseif !Rev then
				MsgC( Color( 100, 50, 200 ), "[ Ayu/Core ] Could not connect to GitHub; Revision check failed.\n" )
			else
				MsgC( Color( 100, 50, 200 ), "[ Ayu/Core ] A newer Revision is availible;\nLatest Rev: ".. Rev .."\nLocal Rev: ".. LRev .."\n" )
				if CLIENT then chat.AddText( Color( 10, 150, 200 ), "[ Ayu/Core ] ".. Color( 255, 255, 255 ),  "A newer Revision is availible;\nLatest Rev: ".. Rev .."\nLocal Rev: ".. LRev .."\n" ) end
			end 
			if !Rev then Ayu.GitRev = Rev end
			if !LRev then Ayu.MyRev = LRev end
		end )
	end )
end
UpdateCheck( )









/* DEPRECATED METHOD OF VERSION GATHERING.
function VerCheckSV( )
	local Path = "ayumia/core/sv_ver.txt"
	local FileR = Path:Read( )

	if FileR == "" then
		local DefVer = "0.0.0_"
		Path:Write( DefVer )
		VerSV = DefVer
	else
		VerSV = FileR
	end

	local TblVer = string.Explode( ".", VerSV, false )
	if( TblVer != nil )and( #TblVer == 3 )then
		MajSV = TblVer[ 1 ]
		MinSV = TblVer[ 2 ]
		RevSV = TblVer[ 3 ]:match( "^%d+" )
	end
end	-- End Func
*/
