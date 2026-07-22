HA$PBExportHeader$w_ge580_monitor_sap.srw
forward
global type w_ge580_monitor_sap from dc_w_consulta_lista
end type
type cbx_1 from checkbox within w_ge580_monitor_sap
end type
type st_1 from statictext within w_ge580_monitor_sap
end type
type st_2 from statictext within w_ge580_monitor_sap
end type
type dw_2 from dc_uo_dw_base within w_ge580_monitor_sap
end type
type dw_3 from dc_uo_dw_base within w_ge580_monitor_sap
end type
type gb_2 from groupbox within w_ge580_monitor_sap
end type
type gb_3 from groupbox within w_ge580_monitor_sap
end type
end forward

global type w_ge580_monitor_sap from dc_w_consulta_lista
integer width = 5742
integer height = 2708
boolean maxbox = true
cbx_1 cbx_1
st_1 st_1
st_2 st_2
dw_2 dw_2
dw_3 dw_3
gb_2 gb_2
gb_3 gb_3
end type
global w_ge580_monitor_sap w_ge580_monitor_sap

on w_ge580_monitor_sap.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.st_1=create st_1
this.st_2=create st_2
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_3
end on

on w_ge580_monitor_sap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;Long	ll_height, ll_width


ll_height 	= this.height
ll_width		= this.width

gb_1.height	= ll_height - 200
dw_1.height	= ll_height - 260

gb_2.height	= (ll_height - 200)/2
dw_2.height	= ((ll_height - 200)/2) - 70

gb_3.y	= gb_2.height + gb_2.y
dw_3.y	= gb_3.y + (gb_2.y - dw_2.y) + 110

gb_3.height	= (ll_height - 200)/2
dw_3.height	= ((ll_height - 200)/2) - 70

dw_2.Trigger Event ue_recuperar()
dw_3.Trigger Event ue_recuperar()

st_2.Text = String(gf_getserverdate(), "dd/mm/yyyy hh:mm:ss")

timer(10)
end event

event timer;call super::timer;Integer 	li_File
Long		ll_erros, ll_row
String	ls_Arquivo

if cbx_1.Checked then
	dw_1.Trigger Event ue_recuperar()
	st_2.Text = String(gf_getserverdate(), "dd/mm/yyyy hh:mm:ss")
	
	dw_2.Trigger Event ue_recuperar()
	dw_3.Trigger Event ue_recuperar()
end if

end event

type dw_visual from dc_w_consulta_lista`dw_visual within w_ge580_monitor_sap
end type

type gb_aux_visual from dc_w_consulta_lista`gb_aux_visual within w_ge580_monitor_sap
end type

type dw_1 from dc_w_consulta_lista`dw_1 within w_ge580_monitor_sap
integer x = 32
integer y = 52
integer width = 2354
string dataobject = "dw_ge580_monitor_subida_resumo"
end type

event dw_1::clicked;call super::clicked;Date		ld_null
Long		ll_cd_tabela, ll_col_row, ll_erros
String	ls_id_subida_descida

SetNull(ld_null)

if left(dwo.name, 4) = 'erro' then
	ll_col_row = Long(right(dwo.name, 1)) + row - 4
	
	ll_cd_tabela			= dw_1.Object.tabela_interface_sap_cd_tabela[ll_col_row]
	ls_id_subida_descida = dw_1.Object.tabela_interface_sap_id_subida_descida[ll_col_row]
	ll_erros					= dw_1.Object.erros[ll_col_row]
	
	if ls_id_subida_descida = 'D' then
		If Not IsValid(w_ge473_interface_sap) Then
			OpenSheet(w_ge473_interface_sap, parent, 0, Original!)
		End If
		
		//w_ge473_interface_sap.Post wf_setar_parametros_monitor_erros(ll_cd_tabela, ll_erros)
		
		w_ge473_interface_sap.SetFocus()
	else
		If Not IsValid(w_ge492_monitor_exp_sap) Then
			OpenSheet(w_ge492_monitor_exp_sap, parent, 0, Original!)
		End If
		
		//w_ge492_monitor_exp_sap.Post wf_setar_parametros_monitor_erros(ll_cd_tabela, ll_erros)
		
		w_ge492_monitor_exp_sap.SetFocus()
	end if
end if
end event

type gb_1 from dc_w_consulta_lista`gb_1 within w_ge580_monitor_sap
integer x = 27
integer y = 0
integer width = 2377
string text = "SAP - Integra$$HEX2$$e700f500$$ENDHEX$$es"
end type

type cbx_1 from checkbox within w_ge580_monitor_sap
integer x = 4704
integer y = 16
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Atualizar"
boolean checked = true
end type

type st_1 from statictext within w_ge580_monitor_sap
integer x = 4704
integer y = 104
integer width = 690
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Ultima Atualiza$$HEX2$$e700e300$$ENDHEX$$o:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge580_monitor_sap
integer x = 4704
integer y = 156
integer width = 699
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_2 from dc_uo_dw_base within w_ge580_monitor_sap
integer x = 2437
integer y = 56
integer width = 2194
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge580_monitor_subida_recebimento"
boolean vscrollbar = true
end type

event ue_recuperar;call super::ue_recuperar;return this.Retrieve()
end event

event clicked;call super::clicked;Date		ld_null
String	ls_cd_fornecedor, ls_id_situacao


SetNull(ld_null)

if dwo.name = 'cf_erros' or dwo.name = 'cf_pendentes' then
	ls_cd_fornecedor	= this.Object.cd_fornecedor[row]
	
	if dwo.name = 'cf_erros' then
		ls_id_situacao	 = 'E'
	else
		ls_id_situacao	 = 'C'
	end if
	
	If Not IsValid(w_ge540_monitor_estorno_recebimento) Then
		OpenSheet(w_ge540_monitor_estorno_recebimento, parent, 0, Original!)
	End If
	
	//w_ge540_monitor_estorno_recebimento.Post wf_setar_parametros_monitor_erros(ls_cd_fornecedor, ls_id_situacao)
		
	w_ge540_monitor_estorno_recebimento.SetFocus()
end if
end event

type dw_3 from dc_uo_dw_base within w_ge580_monitor_sap
integer x = 2437
integer y = 684
integer width = 2194
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge580_monitor_subida_nf"
boolean vscrollbar = true
end type

event clicked;call super::clicked;Date		ld_null
Long		ll_cd_filial
String	ls_id_situacao


SetNull(ld_null)

if dwo.name = 'cf_erros' or dwo.name = 'cf_pendentes' then
	ll_cd_filial	= this.Object.cd_filial[row]
	
	if dwo.name = 'cf_erros' then
		ls_id_situacao	 = 'E'
	else
		ls_id_situacao	 = 'C'
	end if
	
	If Not IsValid(w_ge537_monitor_integracao_sap) Then
		OpenSheet(w_ge537_monitor_integracao_sap, parent, 0, Original!)
	End If
	
	//w_ge537_monitor_integracao_sap.Post wf_setar_parametros_monitor_erros(ll_cd_filial, ls_id_situacao)
		
	w_ge537_monitor_integracao_sap.SetFocus()
end if
end event

event ue_recuperar;call super::ue_recuperar;return this.Retrieve()
end event

type gb_2 from groupbox within w_ge580_monitor_sap
integer x = 2423
integer width = 2222
integer height = 560
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = " Recebimentos "
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge580_monitor_sap
integer x = 2423
integer y = 628
integer width = 2222
integer height = 560
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = " Notas Fiscais "
borderstyle borderstyle = styleraised!
end type

