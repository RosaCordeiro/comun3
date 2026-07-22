HA$PBExportHeader$w_ge135_historico_alteracao.srw
forward
global type w_ge135_historico_alteracao from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge135_historico_alteracao
end type
type gb_1 from groupbox within w_ge135_historico_alteracao
end type
end forward

global type w_ge135_historico_alteracao from dc_w_response
integer width = 3163
integer height = 1256
string title = "GE135 - Hist$$HEX1$$f300$$ENDHEX$$rico Altera$$HEX2$$e700e300$$ENDHEX$$o Pedidos Empurrados por Filial"
dw_1 dw_1
gb_1 gb_1
end type
global w_ge135_historico_alteracao w_ge135_historico_alteracao

on w_ge135_historico_alteracao.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
end on

on w_ge135_historico_alteracao.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;Long ll_Linha
Long ll_linhas

String ls_mensagem
String ls_De
String ls_Para

ls_mensagem = Message.StringParm	
ll_linhas = dw_1.retrieve(ls_mensagem)

If (ll_linhas < 1) Then 
  Messagebox('Hist$$HEX1$$f300$$ENDHEX$$rico de Pedido Empurrado','N$$HEX1$$e300$$ENDHEX$$o existe(m) hist$$HEX1$$f300$$ENDHEX$$rico(s) de altera$$HEX2$$e700e300$$ENDHEX$$o para este produto.')
  Close(This)
  Return 1
End If

For ll_Linha = 1 To ll_Linhas
	ls_De		= String(dw_1.Object.Vl_Origem[ll_Linha])
	ls_Para	= String(dw_1.Object.Vl_Destino[ll_Linha])
	
	//Se houve cancelamento/descancelamento, $$HEX1$$e900$$ENDHEX$$ adicionado Cancelado ou Colocado no relat$$HEX1$$f300$$ENDHEX$$rio
	If ls_De = "X" Then
		dw_1.Object.Vl_Origem[ll_Linha] = "CANCELADO"
	End If
	
	If ls_De = "C" Then
		dw_1.Object.Vl_Origem[ll_Linha] = "COLOCADO"
	End If
	
	If ls_Para = "X" Then
		dw_1.Object.Vl_Destino[ll_Linha] = "CANCELADO"
	End If
	
	If ls_Para = "C" Then
		dw_1.Object.Vl_Destino[ll_Linha] = "COLOCADO"
	End If
Next
end event

type pb_help from dc_w_response`pb_help within w_ge135_historico_alteracao
integer x = 82
integer y = 1240
end type

type dw_1 from dc_uo_dw_base within w_ge135_historico_alteracao
integer x = 59
integer y = 68
integer width = 3013
integer height = 1028
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge135_historico_alteracao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type gb_1 from groupbox within w_ge135_historico_alteracao
integer x = 27
integer y = 16
integer width = 3086
integer height = 1116
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Historico das Altera$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

