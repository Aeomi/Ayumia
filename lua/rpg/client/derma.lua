-- ayu_rpg_requestname
local NameDerma = vgui.Create( "DFrame" )
-- 600x400 window
NameDerma:SetPos( (ScrW()/2)-300, (ScrH()/2)-200 )
NameDerma:SetSize( 600, 300 )
NameDerma:SetTitle( "Enter your name!" )
NameDerma:SetVisible( false )
NameDerma:SetDraggable( true )
NameDerma:ShowCloseButton( false )
NameDerma:MakePopup( )

-- Text field
NameField = vgui.Create( "DTextEntry", NameDerma )
NameField:SetPos( 20, 150 )
NameField:SetTall(24)
NameField:SetWide( 560 )
NameField:SetEnterAllowed( true )
NameField.OnEnter = function()
	if NameField:GetValue():match("^[%a ]+$") != nil then
		Msg( "Your name would be set to "..NameField:GetValue().." right about now." )
		NameDerma:SetVisible( false )
	else
		NameField:SetText( "Invalid name! Try again!" )
		timer.Simple( 1, function( )
			if NameField:GetValue( ) == "Invalid name! Try again!" then
				NameField:SetText( "" )
			end
		end)
	end
end)

concommand.Add("ayu_rpg_requestname", function()
	-- TODO: Check if name hasn't already been set with the server.
	NameDerma:SetVisible( true )
end)