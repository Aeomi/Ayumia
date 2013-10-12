

function VerCheckCL( )
	local Path = "Ayumia/core/cl_ver.txt"
	local FileR = Path:Read( )
	
	if FileR == "" then
		local DefVer = "0.0.0_"
		Path:Write( DefVer )
		VerCL = DefVer
	else
		VerCL = FileR
	end
	
	local TblVer = string.Explode( ".", VerCL, false )
	if( TblVer != nil )and( #TblVer == 3 )then
		MajCL = TblVer[ 1 ]
		MinCL = TblVer[ 2 ]
	end
end	-- End Func
