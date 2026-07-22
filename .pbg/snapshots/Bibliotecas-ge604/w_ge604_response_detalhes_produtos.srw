HA$PBExportHeader$w_ge604_response_detalhes_produtos.srw
forward
global type w_ge604_response_detalhes_produtos from dc_w_response_ok_cancela
end type
type dw_2 from datawindow within w_ge604_response_detalhes_produtos
end type
type gb_2 from groupbox within w_ge604_response_detalhes_produtos
end type
end forward

global type w_ge604_response_detalhes_produtos from dc_w_response_ok_cancela
integer width = 7054
integer height = 2020
dw_2 dw_2
gb_2 gb_2
end type
global w_ge604_response_detalhes_produtos w_ge604_response_detalhes_produtos

type variables
String is_Parametro, is_Tipo, is_pedido, is_pedido_sap
end variables

forward prototypes
public subroutine wf_carrega_dados ()
end prototypes

public subroutine wf_carrega_dados ();
end subroutine

on w_ge604_response_detalhes_produtos.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge604_response_detalhes_produtos.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event open;call super::open;is_Parametro = Message.stringparm

//is_Tipo = Left(is_Parametro, 3)

is_pedido = Mid(is_Parametro, (Pos(is_Parametro, ';')+1), ((LastPos(is_Parametro, ';')-1) - Pos(is_Parametro, ';')) )

is_pedido_sap = Mid(is_Parametro, (LastPos(is_Parametro, ';')+1) )

Dw_1.SetTransObject( SQLCA )
Dw_2.SetTransObject( SQLCA )
end event

event ue_postopen;call super::ue_postopen;String ls_De_Tipo
Long	ll_produtos, ll_Linhas

This.Title = 'GE604 - Detalhes Produtos - N$$HEX1$$ba00$$ENDHEX$$ Ped.: ' + String(is_pedido) + ' | Ped. SAP: ' + String(is_pedido_sap)

Open(w_aguarde)

dw_1.Retrieve (long(is_pedido))

dw_2.Retrieve (long(is_pedido))

Close(w_aguarde)



end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge604_response_detalhes_produtos
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge604_response_detalhes_produtos
integer x = 14
integer y = 28
integer width = 3374
integer height = 1748
string text = "Produtos do Pedido"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge604_response_detalhes_produtos
integer x = 23
integer y = 92
integer width = 3355
integer height = 1656
string dataobject = "dw_ge604_compras_produto"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge604_response_detalhes_produtos
integer x = 6706
integer y = 1812
string text = "&Fechar"
boolean cancel = true
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Close(Parent)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge604_response_detalhes_produtos
boolean visible = false
integer x = 4699
integer y = 1812
boolean enabled = false
string text = "Cancelar"
end type

type dw_2 from datawindow within w_ge604_response_detalhes_produtos
integer x = 3419
integer y = 92
integer width = 3593
integer height = 1656
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge604_compras_produto_por_situacao"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type gb_2 from groupbox within w_ge604_response_detalhes_produtos
integer x = 3415
integer y = 28
integer width = 3602
integer height = 1748
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos com Situa$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

