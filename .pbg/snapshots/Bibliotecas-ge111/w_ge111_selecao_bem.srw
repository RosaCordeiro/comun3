HA$PBExportHeader$w_ge111_selecao_bem.srw
forward
global type w_ge111_selecao_bem from dc_w_selecao_generica
end type
type dw_relatorio from dc_uo_dw_base within w_ge111_selecao_bem
end type
type cb_imprimir from commandbutton within w_ge111_selecao_bem
end type
end forward

global type w_ge111_selecao_bem from dc_w_selecao_generica
integer width = 2551
integer height = 1384
string title = "GE111 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Bem"
long backcolor = 82899184
dw_relatorio dw_relatorio
cb_imprimir cb_imprimir
end type
global w_ge111_selecao_bem w_ge111_selecao_bem

type variables
Long ivl_Filial
end variables

on w_ge111_selecao_bem.create
int iCurrent
call super::create
this.dw_relatorio=create dw_relatorio
this.cb_imprimir=create cb_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_relatorio
this.Control[iCurrent+2]=this.cb_imprimir
end on

on w_ge111_selecao_bem.destroy
call super::destroy
destroy(this.dw_relatorio)
destroy(this.cb_imprimir)
end on

event open;call super::open;uo_Bem lvo_Bem

lvo_Bem = Message.PowerObjectParm

ivl_Filial = lvo_Bem.ivl_Filial_Parametro

dw_1.Object.de_bem[1] = lvo_Bem.de_bem

If IsNull(ivl_Filial) Or ivl_Filial = 0 Then
	ivl_Filial = gvo_Parametro.of_Filial()
End If

dw_Relatorio.Visible = False
end event

event ue_postopen;call super::ue_postopen;String lvs_Bem 

dw_1.Accepttext( )
lvs_Bem = Trim(dw_1.Object.de_bem[1])

If lvs_Bem <> '' Then
	dw_2.Event ue_Retrieve()
End If
end event

event ue_saveas;dw_relatorio.Event ue_SaveAs()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge111_selecao_bem
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge111_selecao_bem
integer y = 288
integer width = 2469
long backcolor = 82899184
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge111_selecao_bem
integer width = 1522
integer height = 268
long backcolor = 82899184
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge111_selecao_bem
integer width = 1467
integer height = 180
string dataobject = "dw_ge111_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge111_selecao_bem
integer y = 360
integer width = 2414
integer height = 736
string dataobject = "dw_ge111_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	lvs_Plaqueta, &
		lvs_Descricao, &
		lvs_Bem


dw_1.AcceptText()

lvs_Plaqueta		= dw_1.Object.cd_plaqueta	[1]
lvs_Descricao	= dw_1.Object.de_bem		[1]
lvs_Bem			= dw_1.Object.cd_bem		[1]	

//If (IsNull(lvs_Descricao) or Trim(lvs_Descricao) = "") and (IsNull(lvs_Codigo) or Trim(lvs_Codigo) = "") Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe algum par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
//	dw_1.Event ue_Pos(1, "cd_plaqueta")
//	Return -1	
//End If

If Not IsNull(lvs_Plaqueta) And Trim(lvs_Plaqueta) <> "" Then
	This.of_AppendWhere("bem.cd_plaqueta = '" + lvs_Plaqueta + "'")
End If

If Not IsNull(lvs_Bem) And Trim(lvs_Bem) <> "" Then
	This.of_AppendWhere("bem.cd_bem = '" + lvs_Bem + "'")
End If

If Not IsNull(lvs_Descricao) And Trim(lvs_Descricao) <> "" Then
	This.of_AppendWhere("bem.de_bem like '" + lvs_Descricao + "%'")
End If

This.of_AppendWhere("bem.cd_filial = " + String(ivl_Filial) )

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	Parent.cb_Imprimir.Enabled = True
Else
	Parent.cb_Imprimir.Enabled = False
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ShareData(dw_Relatorio)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge111_selecao_bem
integer x = 1742
integer y = 1152
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Bem

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Bem = String(dw_2.Object.cd_plaqueta[lvl_Linha])
	CloseWithReturn(Parent, lvs_Bem)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um bem na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge111_selecao_bem
integer x = 2130
integer y = 1152
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Bem

SetNull(lvs_Bem)

CloseWithReturn(Parent, lvs_Bem)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge111_selecao_bem
integer x = 1298
integer y = 1152
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge111_selecao_bem
integer y = 1152
integer width = 1097
long backcolor = 82899184
end type

type dw_relatorio from dc_uo_dw_base within w_ge111_selecao_bem
integer x = 1623
integer y = 20
integer width = 325
integer height = 172
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge111_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.Modify("DataWindow.Print.Preview=Yes")
end event

event ue_preprint;call super::ue_preprint;uo_Filial lvo_Filial
lvo_Filial = Create uo_Filial 

lvo_Filial.of_Localiza_Codigo( ivl_Filial )

This.Object.t_Filial.Text = lvo_Filial.Nm_Fantasia + ' (' + String( ivl_Filial ) + ')'

Destroy(lvo_Filial)

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type cb_imprimir from commandbutton within w_ge111_selecao_bem
integer x = 2098
integer y = 188
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Imprimir"
end type

event clicked;dw_Relatorio.Object.DataWindow.Table.Select = dw_2.Object.DataWindow.Table.Select

dw_Relatorio.Event ue_Print()

Return dw_Relatorio.RowCount()
end event

