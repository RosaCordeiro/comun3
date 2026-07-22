HA$PBExportHeader$w_ge248_consulta_produto.srw
forward
global type w_ge248_consulta_produto from dc_w_sheet
end type
type gb_2 from groupbox within w_ge248_consulta_produto
end type
type gb_1 from groupbox within w_ge248_consulta_produto
end type
type dw_1 from dc_uo_dw_base within w_ge248_consulta_produto
end type
type dw_2 from dc_uo_dw_base within w_ge248_consulta_produto
end type
end forward

global type w_ge248_consulta_produto from dc_w_sheet
integer width = 2039
integer height = 2208
string title = "GE248 - Consulta de Produto"
long backcolor = 80269524
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_ge248_consulta_produto w_ge248_consulta_produto

type variables
uo_produto ivo_produto
end variables

on w_ge248_consulta_produto.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
end on

on w_ge248_consulta_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;dw_1.InsertRow(1)
dw_1.SetFocus()
end event

event open;call super::open;ivo_Produto = Create uo_Produto
end event

event close;call super::close;Destroy(ivo_Produto) 
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge248_consulta_produto
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge248_consulta_produto
end type

type gb_2 from groupbox within w_ge248_consulta_produto
integer x = 23
integer y = 688
integer width = 1943
integer height = 1308
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Distribuidoras"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge248_consulta_produto
integer x = 23
integer y = 16
integer width = 1943
integer height = 652
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Produto"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge248_consulta_produto
integer x = 41
integer y = 60
integer width = 1902
integer height = 580
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge248_produto"
end type

event ue_key;call super::ue_key;Long lvl_Linha

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_localizacao" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			
			This.Event ue_Retrieve()
		End If
	End If
End If
end event

event ue_recuperar;// OverRide

Return This.Retrieve(ivo_Produto.cd_produto)
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event ue_postretrieve;call super::ue_postretrieve;If This.RowCount() > 0 Then
	dw_2.Event ue_Retrieve()
End If

Return 1
end event

type dw_2 from dc_uo_dw_base within w_ge248_consulta_produto
integer x = 55
integer y = 744
integer width = 1888
integer height = 1224
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge248_distribuidoras"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;// OverRide

Long lvl_Linha,&
	 lvl_Produto

dw_1.AcceptText()

lvl_Linha = dw_1.GetRow()

lvl_Produto = dw_1.Object.cd_produto[lvl_Linha]

Return This.Retrieve(lvl_Produto)
end event

