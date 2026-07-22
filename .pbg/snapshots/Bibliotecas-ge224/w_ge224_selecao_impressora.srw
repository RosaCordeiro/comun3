HA$PBExportHeader$w_ge224_selecao_impressora.srw
forward
global type w_ge224_selecao_impressora from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge224_selecao_impressora
end type
type ddlb_impressoras from dropdownlistbox within w_ge224_selecao_impressora
end type
end forward

global type w_ge224_selecao_impressora from dc_w_response_ok_cancela
integer width = 2025
integer height = 312
boolean titlebar = false
long backcolor = 80269524
st_1 st_1
ddlb_impressoras ddlb_impressoras
end type
global w_ge224_selecao_impressora w_ge224_selecao_impressora

type variables
long ivl_Qtde

String is_Impressora
end variables

on w_ge224_selecao_impressora.create
int iCurrent
call super::create
this.st_1=create st_1
this.ddlb_impressoras=create ddlb_impressoras
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.ddlb_impressoras
end on

on w_ge224_selecao_impressora.destroy
call super::destroy
destroy(this.st_1)
destroy(this.ddlb_impressoras)
end on

event ue_preopen;call super::ue_preopen;Long lvl_rc
Long lvl_printerCount
Long lvl_x 

String lvs_printers[] 

ddlb_impressoras.addItem("")

lvl_rc = RegistryValues("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices", lvs_printers) 
If lvl_rc > 0 then 
	lvl_printerCount = UpperBound(lvs_printers) 
	For lvl_x = 1 to lvl_printerCount 
		ddlb_impressoras.addItem(lvs_printers[lvl_x])
	Next 
End If 

ddlb_impressoras.text =  ProfileString(  "c:\sistemas\ws\exe\wms.ini", "Impressora_Danfe", "Impressora_" + gvo_Aplicacao.ivo_seguranca.nr_matricula, "")

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge224_selecao_impressora
boolean visible = false
integer x = 69
integer y = 200
integer width = 50
integer height = 56
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge224_selecao_impressora
integer x = 27
integer y = 12
integer width = 1966
integer height = 160
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge224_selecao_impressora
boolean visible = false
integer x = 73
integer y = 196
integer width = 55
integer height = 48
boolean enabled = false
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge224_selecao_impressora
integer x = 1275
integer y = 184
end type

event cb_ok::clicked;dw_1.AcceptText()

If IsNull(is_Impressora) or is_Impressora = '' Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a impressora.", Exclamation!)
	Return -1
Else
	CloseWithReturn(Parent, is_Impressora)
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge224_selecao_impressora
integer x = 1623
integer y = 184
end type

type st_1 from statictext within w_ge224_selecao_impressora
integer x = 50
integer y = 76
integer width = 329
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Impressora:"
boolean focusrectangle = false
end type

type ddlb_impressoras from dropdownlistbox within w_ge224_selecao_impressora
integer x = 407
integer y = 64
integer width = 1541
integer height = 524
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean vscrollbar = true
borderstyle borderstyle = StyleBox!
end type

event selectionchanged;String ls_Arquivo

ls_Arquivo		= "c:\sistemas\ws\exe\wms.ini"
is_Impressora	= ddlb_impressoras.text

If Not FileExists(ls_Arquivo) Then
	integer li_FileNum
	li_FileNum = FileOpen(ls_Arquivo, LineMode!, Write!, LockWrite!, Append!)
	FileWrite(li_FileNum, "")
	FileClose(li_FileNum)
End If


If SetProfileString(ls_Arquivo, "Impressora_Danfe", "Impressora_" + gvo_Aplicacao.ivo_seguranca.nr_matricula , is_Impressora) <> 1 Then
	MessageBox("Erro", "Erro ao salvar a impressora como padr$$HEX1$$e300$$ENDHEX$$o.")
	Return 1
End If
end event

