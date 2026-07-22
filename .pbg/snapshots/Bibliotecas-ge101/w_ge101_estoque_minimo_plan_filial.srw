HA$PBExportHeader$w_ge101_estoque_minimo_plan_filial.srw
forward
global type w_ge101_estoque_minimo_plan_filial from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge101_estoque_minimo_plan_filial
end type
type gb_2 from groupbox within w_ge101_estoque_minimo_plan_filial
end type
end forward

global type w_ge101_estoque_minimo_plan_filial from dc_w_response_ok_cancela
integer width = 2107
integer height = 1984
string title = "GE101 - Estoque M$$HEX1$$ed00$$ENDHEX$$nimo Planograma por Filial"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge101_estoque_minimo_plan_filial w_ge101_estoque_minimo_plan_filial

type variables
uo_ge216_filiais ivo_Selecao_filiais
uo_filial ivo_filial

String ivs_filiais
end variables

on w_ge101_estoque_minimo_plan_filial.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge101_estoque_minimo_plan_filial.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;String ls_Retorno

ls_Retorno = Message.StringParm

dw_1.Object.Cd_Produto[1] = Long(MidA(ls_Retorno, 1, 6))
dw_1.Object.De_Produto[1] = MidA(ls_Retorno, 7)

dw_2.Event ue_Retrieve()
end event

event close;call super::close;Destroy(ivo_Selecao_filiais)
Destroy(ivo_filial)
end event

event ue_preopen;call super::ue_preopen;ivo_Selecao_filiais = Create uo_ge216_filiais
ivo_filial = Create uo_filial
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge101_estoque_minimo_plan_filial
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge101_estoque_minimo_plan_filial
integer width = 2030
integer height = 244
integer weight = 700
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge101_estoque_minimo_plan_filial
integer width = 1970
integer height = 160
string dataobject = "dw_ge101_selecao_min_plan"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

String ls_Nulo

SetNull(ls_Nulo)

This.AcceptText()

Choose Case This.GetColumnName()
	Case "id_conjunto_filial"
			
		ivs_filiais = ls_Nulo
		
		If Data = 'C' Then
							
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				
				ivo_Filial.of_Inicializa()
				
				ivs_filiais = ivo_Selecao_filiais.ivs_filiais
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
				Return 1
			End If
		End If
		
		dw_2.Event ue_Retrieve()
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge101_estoque_minimo_plan_filial
integer x = 1746
integer y = 1772
end type

event cb_ok::clicked;call super::clicked;Cb_Cancelar.Event Clicked()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge101_estoque_minimo_plan_filial
boolean visible = false
integer x = 46
integer y = 1776
end type

type dw_2 from dc_uo_dw_base within w_ge101_estoque_minimo_plan_filial
integer x = 64
integer y = 312
integer width = 1966
integer height = 1396
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge101_lista_minimo_planograma"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()
end event

event ue_recuperar;//OverRide

If Not IsNull(ivs_Filiais) And Trim(ivs_Filiais) <> "" Then
	This.of_AppendWhere("m.cd_filial in (" + ivs_Filiais + ")")
End If

Return This.Retrieve(dw_1.Object.Cd_Produto[1])
end event

type gb_2 from groupbox within w_ge101_estoque_minimo_plan_filial
integer x = 32
integer y = 256
integer width = 2025
integer height = 1488
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

