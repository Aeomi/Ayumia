

function CheckVerSV( )
	local Path = "Ayumia/core/sv_ver.txt"
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
