HA$PBExportHeader$w_ge327_consulta_produto_abcfarma.srw
forward
global type w_ge327_consulta_produto_abcfarma from dc_w_sheet
end type
type gb_1 from groupbox within w_ge327_consulta_produto_abcfarma
end type
type dw_1 from dc_uo_dw_base within w_ge327_consulta_produto_abcfarma
end type
end forward

global type w_ge327_consulta_produto_abcfarma from dc_w_sheet
string tag = "w_ge327_consulta_produto_abcfarma"
integer width = 2144
integer height = 1284
string title = "GE327 - Consulta de Produtos do Caderno ABC Farma"
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
end type
global w_ge327_consulta_produto_abcfarma w_ge327_consulta_produto_abcfarma

type variables
uo_produto_abcfarma ivo_produto
end variables

on w_ge327_consulta_produto_abcfarma.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_ge327_consulta_produto_abcfarma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;call super::open;ivo_Produto = Create uo_Produto_ABCFarma
end event

event close;call super::close;Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge327_consulta_produto_abcfarma
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge327_consulta_produto_abcfarma
end type

type gb_1 from groupbox within w_ge327_consulta_produto_abcfarma
integer x = 14
integer width = 2071
integer height = 1080
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge327_consulta_produto_abcfarma
integer x = 32
integer y = 56
integer width = 2039
integer height = 1008
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge327_consulta"
end type

event ue_key;If Key = KeyEnter! Then 
	ivo_Produto.of_Localiza_Produto(This.GetText())
	
	If ivo_Produto.Localizado Then
		This.Event ue_Retrieve()
	End If	
End If
end event

event ue_recuperar;// Override

Return This.Retrieve(ivo_Produto.Cd_Produto_AbcFarma)
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

