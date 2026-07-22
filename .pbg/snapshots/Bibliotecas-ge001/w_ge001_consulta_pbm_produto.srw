HA$PBExportHeader$w_ge001_consulta_pbm_produto.srw
forward
global type w_ge001_consulta_pbm_produto from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge001_consulta_pbm_produto
end type
type dw_2 from dc_uo_dw_base within w_ge001_consulta_pbm_produto
end type
type cb_confirmar from commandbutton within w_ge001_consulta_pbm_produto
end type
type cb_cancelar from commandbutton within w_ge001_consulta_pbm_produto
end type
type dw_3 from dc_uo_dw_base within w_ge001_consulta_pbm_produto
end type
type dw_4 from dc_uo_dw_base within w_ge001_consulta_pbm_produto
end type
type gb_2 from groupbox within w_ge001_consulta_pbm_produto
end type
type gb_1 from groupbox within w_ge001_consulta_pbm_produto
end type
type gb_3 from groupbox within w_ge001_consulta_pbm_produto
end type
type gb_progressiva from groupbox within w_ge001_consulta_pbm_produto
end type
end forward

global type w_ge001_consulta_pbm_produto from dc_w_response
integer width = 3575
integer height = 1628
string title = "GE001 - Consulta de PBMs por Produto"
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
global w_ge001_consulta_pbm_produto w_ge001_consulta_pbm_produto

type variables
Long ivl_Produto
end variables

on w_ge001_consulta_pbm_produto.create
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

on w_ge001_consulta_pbm_produto.destroy
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

type pb_help from dc_w_response`pb_help within w_ge001_consulta_pbm_produto
end type

type dw_1 from dc_uo_dw_base within w_ge001_consulta_pbm_produto
integer x = 64
integer y = 72
integer width = 3438
integer height = 480
boolean bringtotop = true
string dataobject = "dw_ge001_lista_pbm"
boolean vscrollbar = true
end type

event ue_recuperar;//Override
If This.DataObject = 'dw_ge001_lista_pbm' Then
	Return This.Retrieve(ivl_Produto,gvo_parametro.ivs_uf_filial)
Else
	Return This.Retrieve(ivl_Produto)	
End If
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.Event ue_Retrieve()
	dw_3.Event ue_Retrieve()
End If

dw_1.SetFocus()

This.of_SetRowSelection()

Return pl_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;dw_2.Event ue_Retrieve()
dw_3.Event ue_Retrieve()
end event

event ue_preretrieve;call super::ue_preretrieve;If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "CL" Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "RL" Then 
		This.DataObject = 'dw_ge001_lista_pbm_central'
		This.SetTransObject(SqlCa)
	End If
End If

Return AncestorReturnValue
end event

type dw_2 from dc_uo_dw_base within w_ge001_consulta_pbm_produto
integer x = 96
integer y = 668
integer width = 1701
integer height = 816
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge001_detalhes_pbm"
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

type cb_confirmar from commandbutton within w_ge001_consulta_pbm_produto
integer x = 1957
integer y = 1428
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

type cb_cancelar from commandbutton within w_ge001_consulta_pbm_produto
integer x = 2341
integer y = 1428
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

type dw_3 from dc_uo_dw_base within w_ge001_consulta_pbm_produto
integer x = 1902
integer y = 632
integer width = 1591
integer height = 340
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge001_observacao_pbm"
end type

event ue_recuperar;//OverRide

Return This.Retrieve(dw_1.Object.Cd_Pbm[dw_1.GetRow()])
end event

type dw_4 from dc_uo_dw_base within w_ge001_consulta_pbm_produto
boolean visible = false
integer x = 1911
integer y = 1048
integer width = 1595
integer height = 352
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge001_pbm_progressivo"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

Return This.Retrieve(dw_1.Object.Cd_Pbm[dw_1.GetRow()])
end event

type gb_2 from groupbox within w_ge001_consulta_pbm_produto
integer x = 32
integer y = 572
integer width = 1801
integer height = 964
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

type gb_1 from groupbox within w_ge001_consulta_pbm_produto
integer x = 32
integer y = 20
integer width = 3506
integer height = 552
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

type gb_3 from groupbox within w_ge001_consulta_pbm_produto
integer x = 1870
integer y = 572
integer width = 1664
integer height = 420
integer taborder = 30
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

type gb_progressiva from groupbox within w_ge001_consulta_pbm_produto
boolean visible = false
integer x = 1870
integer y = 992
integer width = 1664
integer height = 420
integer taborder = 40
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

