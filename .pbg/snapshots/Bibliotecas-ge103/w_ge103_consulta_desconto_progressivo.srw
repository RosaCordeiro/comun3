HA$PBExportHeader$w_ge103_consulta_desconto_progressivo.srw
forward
global type w_ge103_consulta_desconto_progressivo from dc_w_response
end type
type gb_1 from groupbox within w_ge103_consulta_desconto_progressivo
end type
type dw_1 from dc_uo_dw_base within w_ge103_consulta_desconto_progressivo
end type
type dw_2 from dc_uo_dw_base within w_ge103_consulta_desconto_progressivo
end type
type gb_2 from groupbox within w_ge103_consulta_desconto_progressivo
end type
end forward

global type w_ge103_consulta_desconto_progressivo from dc_w_response
integer width = 3922
integer height = 664
string title = "GE103 - Promo$$HEX2$$e700e300$$ENDHEX$$o Progressiva : "
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
gb_2 gb_2
end type
global w_ge103_consulta_desconto_progressivo w_ge103_consulta_desconto_progressivo

type variables
uo_produto ivo_produto


long ivl_produto
Long ivl_Filial
end variables

forward prototypes
public function string wf_identifica_valor_parametro (string ps_parametro, integer pi_coluna)
end prototypes

public function string wf_identifica_valor_parametro (string ps_parametro, integer pi_coluna);String lvs_Coluna

Integer lvi_Contador, &
        lvi_Posicao = -2, &
        lvi_Start

For lvi_Contador = 1 To pi_Coluna
	lvi_Start = lvi_Posicao + 3
	
	lvi_Posicao = PosA(ps_Parametro, "@#!", lvi_Start)
Next

If lvi_Posicao = 0 Then
	lvs_Coluna = MidA(ps_Parametro, lvi_Start)
Else
	lvs_Coluna = MidA(ps_Parametro, lvi_Start, lvi_Posicao - lvi_Start)
End If

Return lvs_Coluna
end function

on w_ge103_consulta_desconto_progressivo.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.gb_2
end on

on w_ge103_consulta_desconto_progressivo.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.gb_2)
end on

event open;//OverRide
Long lvl_Nulo
Boolean lvb_Sucesso = False

String 	ls_Parametro

pb_Help.Visible = False
ls_Parametro = Message.StringParm

ivo_Produto 	= Create uo_Produto


ivl_Produto	= Long(wf_Identifica_Valor_Parametro(ls_Parametro, 1))
ivl_Filial		= Long(wf_Identifica_Valor_Parametro(ls_Parametro, 2))

ivo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)
If ivo_Produto.Localizado Then
		
	This.Title = This.Title + ' - Filial :' + String(ivl_Filial) + ' - Produto :' + String(ivl_Produto)
	
	dw_1.Event ue_Retrieve()
	dw_2.Event ue_Retrieve()
		
	If dw_1.RowCount() = 0 and dw_2.RowCount()=0 Then
		SetNull(lvl_Nulo)
		CloseWithReturn(This, lvl_Nulo)
	End If
End If

end event

type pb_help from dc_w_response`pb_help within w_ge103_consulta_desconto_progressivo
integer y = 1044
end type

type gb_1 from groupbox within w_ge103_consulta_desconto_progressivo
integer x = 32
integer y = 20
integer width = 1915
integer height = 544
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Desconto Normal"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge103_consulta_desconto_progressivo
integer x = 64
integer y = 76
integer width = 1874
integer height = 472
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge103_lista_desconto_progressivo"
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide
Return This.Retrieve(ivl_Produto, ivl_Filial )
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type dw_2 from dc_uo_dw_base within w_ge103_consulta_desconto_progressivo
integer x = 2002
integer y = 72
integer width = 1874
integer height = 472
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge103_lista_desconto_progr_clube"
end type

event ue_recuperar;// OverRide
Return This.Retrieve(ivl_Produto, ivl_Filial )
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type gb_2 from groupbox within w_ge103_consulta_desconto_progressivo
integer x = 1979
integer y = 20
integer width = 1915
integer height = 544
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Desconto Clube"
end type

