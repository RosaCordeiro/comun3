HA$PBExportHeader$w_ge114_selecao_condicao_crediario.srw
forward
global type w_ge114_selecao_condicao_crediario from window
end type
type cb_cancelar from commandbutton within w_ge114_selecao_condicao_crediario
end type
type cb_1 from commandbutton within w_ge114_selecao_condicao_crediario
end type
type dw_2 from dc_uo_dw_base within w_ge114_selecao_condicao_crediario
end type
type dw_1 from dc_uo_dw_base within w_ge114_selecao_condicao_crediario
end type
type gb_2 from groupbox within w_ge114_selecao_condicao_crediario
end type
type gb_1 from groupbox within w_ge114_selecao_condicao_crediario
end type
end forward

global type w_ge114_selecao_condicao_crediario from window
integer x = 123
integer y = 336
integer width = 3488
integer height = 1732
boolean titlebar = true
string title = "GE114 - Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento Credi$$HEX1$$e100$$ENDHEX$$rio"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cb_cancelar cb_cancelar
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
end type
global w_ge114_selecao_condicao_crediario w_ge114_selecao_condicao_crediario

type variables
uo_GE114_Condicao_Crediario ivo_Condicao
end variables

forward prototypes
public subroutine wf_selecao_parcelas (long pl_row)
end prototypes

public subroutine wf_selecao_parcelas (long pl_row);Long   ll_condicao, ll_parcela
String ls_desconto
Date   ld_data

ll_condicao = dw_1.Object.cd_condicao_crediario [pl_row]
ll_parcela  = dw_1.Object.nr_parcelas [pl_row]
ld_data     = Date(ivo_Condicao.dh_movimentacao)

If IsNull(ll_condicao) Then Return

dw_2.retrieve(ll_condicao, ivo_Condicao.vl_total_venda,ld_data,ll_parcela)



end subroutine

on w_ge114_selecao_condicao_crediario.create
this.cb_cancelar=create cb_cancelar
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_cancelar,&
this.cb_1,&
this.dw_2,&
this.dw_1,&
this.gb_2,&
this.gb_1}
end on

on w_ge114_selecao_condicao_crediario.destroy
destroy(this.cb_cancelar)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

ivo_Condicao = Create uo_GE114_Condicao_Crediario
ivo_Condicao = Message.PowerObjectParm
ivo_Condicao.Retorno = ''

If Not gf_Data_Parametro( ref ivo_Condicao.Dh_Movimentacao ) Then Return -1

dw_1.Retrieve()
dw_1.SetFocus()

If Not IsNull(ivo_Condicao.ivo_pedido.nr_pedido_drogaexpress) Then
	
	Long ll_find
	
	ll_find = dw_1.Find('cd_condicao_crediario = ' + String( ivo_Condicao.ivo_Pedido.cd_Condicao_Crediario ), 1,dw_1.RowCount() )
	
	If ll_find > 0 Then
		
		dw_1.SetRow(ll_find)
		dw_1.ScrolltoRow(ll_find)
		dw_1.Enabled = False
		
		cb_1.Event Clicked()
		
	End If

End If
end event

event closequery;IF KeyDown(KeyAlt!) and KeyDown(KeyF4!) Then Return 1


	
	
end event

type cb_cancelar from commandbutton within w_ge114_selecao_condicao_crediario
integer x = 3072
integer y = 1508
integer width = 370
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event losefocus;This.Default = False
This.Weight = 400
end event

event getfocus;This.Default = True
This.Weight = 700
end event

event clicked;ivo_Condicao.retorno = 'CANCELAR'

CloseWithReturn(Parent,ivo_Condicao)
end event

type cb_1 from commandbutton within w_ge114_selecao_condicao_crediario
integer x = 2683
integer y = 1508
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
boolean default = true
end type

event getfocus;This.Default = True
This.Weight = 700
end event

event losefocus;This.Default = False
This.Weight = 400
end event

event clicked;ivo_Condicao.vl_entrada_crediario = 000.00

Long ll_row

ll_row = dw_1.GetRow()

If ll_row <= 0 Then Return 

ivo_Condicao.cd_condicao_crediario	= dw_1.Object.cd_condicao_crediario	[ll_row]
ivo_Condicao.de_condicao_crediario	= dw_1.Object.de_condicao_crediario	[ll_row]
ivo_Condicao.nr_parcela_crediario		= dw_1.Object.nr_parcelas					[ll_row]

If dw_2.RowCount() > 0 Then
	
	If dw_2.Object.nr_dias_vencimento [1] = 0 Then
		ivo_Condicao.vl_entrada_crediario		= dw_2.GetItemDecimal(1, "c_valor_final_parc")
		ivo_Condicao.pc_entrada_crediario	= dw_2.GetItemDecimal(1, "pc_valor_total")
	End If
	
End If

ivo_Condicao.retorno = 'OK'

CloseWithReturn(Parent,ivo_Condicao)
end event

type dw_2 from dc_uo_dw_base within w_ge114_selecao_condicao_crediario
integer x = 1733
integer y = 84
integer width = 1678
integer height = 1392
integer taborder = 0
string dataobject = "dw_ge114_parcelas_condicao_crediario"
boolean vscrollbar = true
end type

type dw_1 from dc_uo_dw_base within w_ge114_selecao_condicao_crediario
integer x = 78
integer y = 84
integer width = 1550
integer height = 1392
string dataobject = "dw_ge114_condicao_crediario"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow = 0 Then Return

wf_selecao_parcelas(currentrow)

end event

type gb_2 from groupbox within w_ge114_selecao_condicao_crediario
integer x = 1701
integer y = 20
integer width = 1737
integer height = 1472
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Parcelas Previstas"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge114_selecao_condicao_crediario
integer x = 41
integer y = 20
integer width = 1627
integer height = 1472
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento"
borderstyle borderstyle = styleraised!
end type

