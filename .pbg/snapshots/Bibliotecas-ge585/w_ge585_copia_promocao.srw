HA$PBExportHeader$w_ge585_copia_promocao.srw
forward
global type w_ge585_copia_promocao from dc_w_response
end type
type gb_1 from groupbox within w_ge585_copia_promocao
end type
type dw_1 from dc_uo_dw_base within w_ge585_copia_promocao
end type
type cb_confirmar from commandbutton within w_ge585_copia_promocao
end type
type cb_cancelar from commandbutton within w_ge585_copia_promocao
end type
end forward

global type w_ge585_copia_promocao from dc_w_response
integer width = 1655
integer height = 480
string title = "CO077 - Copia de Outra Promo$$HEX2$$e700e300$$ENDHEX$$o"
boolean controlmenu = false
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
end type
global w_ge585_copia_promocao w_ge585_copia_promocao

type variables
uo_promocao ivo_promocao
end variables

on w_ge585_copia_promocao.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_confirmar
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_ge585_copia_promocao.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
end on

event open;call super::open;ivo_Promocao = Create uo_Promocao
end event

event close;call super::close;Destroy(ivo_Promocao)
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

type pb_help from dc_w_response`pb_help within w_ge585_copia_promocao
end type

type gb_1 from groupbox within w_ge585_copia_promocao
integer x = 23
integer width = 1591
integer height = 264
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge585_copia_promocao
integer x = 50
integer y = 56
integer width = 1554
integer height = 184
boolean bringtotop = true
string dataobject = "dw_ge585_promocao_copia"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_promocao" Then
		ivo_Promocao.of_Localiza(This.GetText())

		If ivo_Promocao.Localizado Then
			This.Object.Cd_Promocao[1] = ivo_Promocao.Cd_Promocao
			This.Object.Nm_Promocao[1] = ivo_Promocao.Nm_Promocao
		End If
	End If
End If
end event

event losefocus;call super::losefocus;If IsValid(ivo_Promocao) Then
	This.Object.Nm_Promocao[1] = ivo_Promocao.Nm_Promocao
End If
end event

event itemchanged;call super::itemchanged;If dwo.Name = "nm_promocao" Then
	If Data <> ivo_Promocao.Nm_Promocao Then
		Return 1
	End If
End If
end event

type cb_confirmar from commandbutton within w_ge585_copia_promocao
integer x = 814
integer y = 276
integer width = 389
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Con&firmar"
end type

event clicked;Long lvl_Promocao

dw_1.AcceptText()

lvl_Promocao = dw_1.Object.Cd_Promocao[1]

If IsNull(lvl_Promocao) or lvl_Promocao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma promo$$HEX2$$e700e300$$ENDHEX$$o para copiar os produtos e/ou filiais.")
	dw_1.Event ue_Pos(1, "nm_promocao")
	Return
End If

CloseWithReturn(Parent, "S" + String(lvl_Promocao, "000000"))
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type cb_cancelar from commandbutton within w_ge585_copia_promocao
integer x = 1225
integer y = 276
integer width = 389
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "N")
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

