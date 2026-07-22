HA$PBExportHeader$w_ge113_consulta_pbm_produto.srw
forward
global type w_ge113_consulta_pbm_produto from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge113_consulta_pbm_produto
end type
type dw_2 from dc_uo_dw_base within w_ge113_consulta_pbm_produto
end type
type cb_confirmar from commandbutton within w_ge113_consulta_pbm_produto
end type
type cb_cancelar from commandbutton within w_ge113_consulta_pbm_produto
end type
type dw_3 from dc_uo_dw_base within w_ge113_consulta_pbm_produto
end type
type dw_4 from dc_uo_dw_base within w_ge113_consulta_pbm_produto
end type
type gb_2 from groupbox within w_ge113_consulta_pbm_produto
end type
type gb_1 from groupbox within w_ge113_consulta_pbm_produto
end type
type gb_3 from groupbox within w_ge113_consulta_pbm_produto
end type
type gb_progressiva from groupbox within w_ge113_consulta_pbm_produto
end type
end forward

global type w_ge113_consulta_pbm_produto from dc_w_response
integer width = 3387
integer height = 1760
string title = "GE113 - Consulta de PBMs por Produto"
long backcolor = 82899184
dw_1 dw_1
dw_2 dw_2
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
dw_3 dw_3
dw_4 dw_4
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
gb_progressiva gb_progressiva
end type
global w_ge113_consulta_pbm_produto w_ge113_consulta_pbm_produto

type variables
Long ivl_Produto
end variables

on w_ge113_consulta_pbm_produto.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.dw_3=create dw_3
this.dw_4=create dw_4
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_progressiva=create gb_progressiva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_confirmar
this.Control[iCurrent+4]=this.cb_cancelar
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_progressiva
end on

on w_ge113_consulta_pbm_produto.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_progressiva)
end on

event open;call super::open;ivl_Produto = Message.DoubleParm
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response`pb_help within w_ge113_consulta_pbm_produto
end type

type dw_1 from dc_uo_dw_base within w_ge113_consulta_pbm_produto
integer x = 64
integer y = 72
integer width = 3241
integer height = 524
boolean bringtotop = true
string dataobject = "dw_ge113_lista_pbm"
boolean vscrollbar = true
end type

event ue_recuperar;//Override
Return This.Retrieve(ivl_Produto)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.Event ue_Retrieve()
	dw_3.Event ue_Retrieve()
End If

Return pl_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;dw_2.Event ue_Retrieve()
dw_3.Event ue_Retrieve()
end event

type dw_2 from dc_uo_dw_base within w_ge113_consulta_pbm_produto
integer x = 64
integer y = 704
integer width = 1723
integer height = 808
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge113_detalhes_pbm"
end type

event ue_recuperar;//Override

Long lvl_PBM

dw_1.AcceptText()

lvl_PBM = dw_1.Object.cd_pbm[dw_1.GetRow()]

Return This.Retrieve(lvl_PBM, ivl_Produto)


end event

event ue_postretrieve;call super::ue_postretrieve;Long lvl_PBM
Long lvl_produto

dw_1.AcceptText()
lvl_PBM = dw_1.Object.cd_pbm[dw_1.GetRow()]

If pl_Linhas > 0 Then
	If This.object.cd_progressiva[This.GetRow()] > 0 Then
		gb_progressiva.Visible = True
		dw_4.visible = True
		Return dw_4.Retrieve(lvl_PBM, ivl_Produto)
	Else
		gb_progressiva.Visible = False
		dw_4.visible = False
	End If
End If

Return pl_Linhas
end event

type cb_confirmar from commandbutton within w_ge113_consulta_pbm_produto
integer x = 1833
integer y = 1548
integer width = 370
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
boolean default = true
end type

event clicked;Close(Parent)
end event

type cb_cancelar from commandbutton within w_ge113_consulta_pbm_produto
integer x = 2263
integer y = 1548
integer width = 370
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type dw_3 from dc_uo_dw_base within w_ge113_consulta_pbm_produto
integer x = 1851
integer y = 696
integer width = 1445
integer height = 340
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge113_observacao_pbm"
end type

event ue_recuperar;//OverRide

Return This.Retrieve(dw_1.Object.Cd_Pbm[dw_1.GetRow()])
end event

type dw_4 from dc_uo_dw_base within w_ge113_consulta_pbm_produto
integer x = 1856
integer y = 1152
integer width = 1449
integer height = 364
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge113_pbm_progressivo"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_2 from groupbox within w_ge113_consulta_pbm_produto
integer x = 37
integer y = 636
integer width = 1765
integer height = 892
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 82899184
string text = "Detalhes do PBM"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge113_consulta_pbm_produto
integer x = 32
integer y = 20
integer width = 3296
integer height = 596
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 82899184
string text = "Lista de PBMs"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge113_consulta_pbm_produto
integer x = 1810
integer y = 636
integer width = 1513
integer height = 424
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Observa$$HEX2$$e700e300$$ENDHEX$$o PBM"
end type

type gb_progressiva from groupbox within w_ge113_consulta_pbm_produto
integer x = 1810
integer y = 1084
integer width = 1513
integer height = 444
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Progressivo"
end type

