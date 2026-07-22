HA$PBExportHeader$dc_uo_menu_base.sru
forward
global type dc_uo_menu_base from nonvisualobject
end type
end forward

global type dc_uo_menu_base from nonvisualobject
end type
global dc_uo_menu_base dc_uo_menu_base

forward prototypes
public function integer of_getmdiframe (menu pm_menu, ref window pw_janela)
public function integer of_sendmessage (menu pm_menu, string ps_mensagem)
public function integer of_help (menu pm_menu, string ps_arquivo)
end prototypes

public function integer of_getmdiframe (menu pm_menu, ref window pw_janela);window	lw_obj
boolean	lb_foundframe=False

//Check arguments
If Not IsValid(pm_Menu) or IsNull(pm_Menu) Then
	SetNull (pw_Janela)
	Return -1
End If

//Get the window that owns the Menu object.
lw_obj = pm_Menu.ParentWindow

//Search until no more windows or a MDI type window is found.
Do While IsValid (lw_obj)
	If lw_obj.windowtype = mdi! or lw_obj.windowtype = mdihelp! Then
		//Found a MDI Frame
		lb_foundframe = true
		Exit
	Else
		//Look in the window's parent (if any)
		lw_obj = lw_obj.ParentWindow()
	End if
Loop

If Not lb_foundframe Then
	//MDI Frame was not found
	SetNull (pw_Janela)
	Return -1
End If

//MDI Frame was found
pw_Janela = lw_obj
Return 1

end function

public function integer of_sendmessage (menu pm_menu, string ps_mensagem);integer		li_rc = -1
window		lw_frame
window		lw_sheet

// Check arguments
if IsNull (ps_Mensagem) or LenA (Trim (ps_Mensagem)) = 0 then
	return li_rc
end if

// Determine if application is MDI by getting frame window
of_GetMDIFrame (pm_Menu, lw_frame)   
if IsValid (lw_frame) then

	// Try sending the message to the active MDI sheet
	lw_sheet = lw_frame.GetActiveSheet()
	if IsValid (lw_sheet) then
		li_rc = lw_sheet.dynamic event ue_messagerouter (ps_Mensagem)
	end if

	if li_rc <> 1 then
		// Try sending the message to the frame
		li_rc = lw_frame.dynamic event ue_messagerouter (ps_Mensagem)
	end if
else
	// Try sending the message to the parentwindow
	if IsValid (pm_Menu.parentwindow) then
		li_rc = pm_Menu.parentwindow.dynamic event ue_messagerouter (ps_Mensagem)
	end if
end if

if IsNull (li_rc) then
	li_rc = -1
end if

return li_rc

end function

public function integer of_help (menu pm_menu, string ps_arquivo);integer		li_rc = -1
window	lw_frame
window	lw_sheet

String	lvs_Exe, &
		lvs_Arquivo
		
lvs_Arquivo  = ''	

If ps_Arquivo = '' Then
	// Determine if application is MDI by getting frame window
	of_GetMDIFrame (pm_menu, lw_frame)   
	if IsValid (lw_frame) then
	
		// Try sending the message to the active MDI sheet
		lw_sheet = lw_frame.GetActiveSheet()
		
		if IsValid (lw_sheet) then
			lvs_Arquivo = lw_sheet.accessiblename
		end if
	else
		// Try sending the message to the parentwindow
		if IsValid (pm_menu.parentwindow) then
			lvs_Arquivo = ''
		end if
	end if
Else
	lvs_Arquivo = ps_Arquivo
End If

If Lower( RightA( Trim( gvo_Aplicacao.ivs_Path_Manual ), 3 ) ) = 'chm' Then
	If lvs_Arquivo = '' Then
		ShowHelp( gvo_Aplicacao.ivs_Path_Manual, Index! )
	Else
		ShowHelp( gvo_Aplicacao.ivs_Path_Manual, KeyWord!, lvs_Arquivo )
	End If
		
Else	
	If IsNull(lvs_Arquivo) or lvs_Arquivo = ""  Then
		lvs_Arquivo = gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "_index"
	End If
	
	lvs_Exe = gvo_Aplicacao.ivs_Path_Manual  + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema +"/" + Trim(lvs_Arquivo)  + ".html"
	
	dc_uo_api lvo_api
	lvo_api = Create dc_uo_api
	
	lvo_api.of_Shell_Execute(lvs_Exe, '')
	
	Destroy(lvo_Api)
End If

return li_rc
end function

on dc_uo_menu_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_menu_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

