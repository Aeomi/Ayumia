--hook.Add( "Initialize", "AyuMFont", function( )
function CreateFonts( )
	surface.CreateFont( "AyuLBFont", {
        font =          "Times New Roman";
        size =          20;
        weight =        250;
        antialias =     true;
        additive =      true;
        outline =       true
    } )
    surface.CreateFont( "AyuMBFont", {
        font =          "Times New Roman";
        size =          18;
        weight =        250;
        antialias =     true;
        additive =      true;
        outline =       true
    } )
    surface.CreateFont( "AyuSBFont", {
        font =          "Times New Roman";
        size =          14;
        weight =        250;
        antialias =     true;
        additive =      true;
        outline =       true
    } )
    surface.CreateFont( "AyuButtonFont", {
        font =          "Times New Roman";
        size =          14;
        weight =        250;
        antialias =     true;
        outline =       true;
		shadow = 		true 
    } )
end 
CreateFonts( )

concommand.Add( "Ayu_Rpg_Derma_NameMenu", function( )
	
	/*----------|
	|   Derma   |
	|----------*/
	
	//-- Main Template --//
	local MainMenu = vgui.Create( "DFrame" )
	MainMenu:SetPos( ( ScrW( )/3)-300, ( ScrH( )/3 )-200 )
	MainMenu:SetSize( 275, 100 )
	MainMenu:SetTitle( "")--Name Selection Panel" )
	MainMenu:SetBackgroundBlur( true )
	MainMenu:SetVisible( false )
	MainMenu:SetDraggable( true )
	MainMenu:ShowCloseButton( false )
	MainMenu:MakePopup( )
	MainMenu.Paint = function( ) 
		draw.RoundedBox( 8, 0, 0, MainMenu:GetWide( ), MainMenu:GetTall( ), Color( 75, 75, 75, 250 ) )
		draw.DrawText( "Enter your Name:", "AyuSBFont", 50, 74, Color( 75, 75, 200, 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( "Name Selection Screen", "AyuSBFont", 60, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
		DNameText = ""
		DNameTextColorBool = true
		if DNameTextColorBool == false then 
			DNameTextColor = Color( 200, 50, 75 ) 
		else 
			DNameTextColor = Color( 50, 75, 200 ) 
		end
		draw.DrawText( DNameText, "AyuLBFont", 100, 35, DNameTextColor, TEXT_ALIGN_CENTER )
	end
	//-------------------//
	
	
	//-- Text Field --//
	NameField = vgui.Create( "DTextEntry", MainMenu )
	NameField:SetPos( 95, 75 )
	NameField:SetTall( 14 )
	NameField:SetWide( 110 )
	NameField:SetEnterAllowed( true )
	NameField.OnEnter = function( )
		if NameField:GetValue( ):match( "^[%a ]+$" ) != nil then
			Msg( NameField:GetValue( ) .."\n" ) 
			net.Start( "ClientName" )
			net.WriteString( NameField:GetValue( ) )
			net.SendToServer( )
			DNameText = "Your name is being changed..."
			DNameTextColorBool = true
		else
			DNameTextColorBool = false
			DNameText = ( "The Name '".. NameField:GetValue( ) .."' contains illegal characters \nAllowed characters range from A - Z" )
		end
	end
	//----------------//
	
	
	//-- Send TextField Button --//
	local BtnSubmit = vgui.Create( "DButton", MainMenu )
	BtnSubmit:SetPos( 210, 74 )
	BtnSubmit:SetSize( 50, 16 )
	BtnSubmit:SetFont( "AyuButtonFont" )
	BtnSubmit:SetText( "Send" )
	BtnSubmit.Paint = function( )
		draw.RoundedBox( 2, 0, 0, BtnSubmit:GetWide( ), BtnSubmit:GetTall( ), Color( 25, 25, 25, 255 ) )
	end
	BtnSubmit.DoClick = function( )
		BtnSubmit:SetText( "Sending" )
		
		timer.Simple( 0.5, function( )
			MainMenu:SetVisible( false )
		end )
	end
	//---------------------------//
	
	
	//-- Close Button--//
	local BtnClose = vgui.Create( "DButton", MainMenu ) 
	timer.Create( "Dec1", 0.1, 10, function( ) BtnCloseTxt = BtnCloseTxt - 1 end )
	timer.Stop( "Dec1" )
	BtnCloseTxt = 10
	BtnClose:SetPos( 237, 5 )
	BtnClose:SetSize( 30, 17 )
	local BtnCloseTglTxt = false
	if !BtnCloseTglTxt then
		BtnClose:SetFont( "Marlett" )
		BtnClose:SetText( "r" )
	end
	BtnClose.Paint = function( )
		draw.RoundedBox( 2, 0, 0, BtnClose:GetWide( ), BtnClose:GetTall( ), Color( 25, 25, 25, 255 ) )
		if BtnCloseTglTxt then
			BtnClose:SetFont( "AyuButtonFont" )
			BtnClose:SetText( BtnCloseTxt )
		end	
	end
	BtnClose.DoClick = function( )
		BtnCloseTglTxt = true
		timer.Start( "Dec1" )
		timer.Simple( 1, function( ) MainMenu:SetVisible( false ) end )
	end
	//-----------------//
	
	
MainMenu:SetVisible( true ) -- Open Name Menu
end ) -- End Concommand