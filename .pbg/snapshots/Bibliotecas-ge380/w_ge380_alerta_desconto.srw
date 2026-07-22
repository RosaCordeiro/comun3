HA$PBExportHeader$w_ge380_alerta_desconto.srw
forward
global type w_ge380_alerta_desconto from dc_w_response_ok_cancela
end type
end forward

global type w_ge380_alerta_desconto from dc_w_response_ok_cancela
integer width = 2130
integer height = 1420
string title = "GE380 - Alerta de Desconto Maior que 75(%)"
end type
global w_ge380_alerta_desconto w_ge380_alerta_desconto

on w_ge380_alerta_desconto.create
call super::create
end on

on w_ge380_alerta_desconto.destroy
call super::destroy
end on

event ue_postopen;//OverRide

dw_1.of_Set_Somente_Leitura(False)
end event

event open;call super::open;str_ge380_dados_promocao st

st = Message.PowerObjectParm

Long ll_Linha

For ll_Linha = 1 To UpperBound(st.Cd_Produto[])
	dw_1.Event ue_AddRow()
	
	dw_1.Object.Cd_Produto				[ll_Linha] = st.Cd_Produto			[ll_Linha]
	dw_1.Object.De_Produto				[ll_Linha] = st.De_Produto			[ll_Linha]
	dw_1.Object.Pc_Desconto			[ll_Linha] = st.Pc_Desconto			[ll_Linha]
	dw_1.Object.Pc_Desconto_Clube	[ll_Linha] = st.Pc_Desconto_Clube	[ll_Linha]
Next
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge380_alerta_desconto
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge380_alerta_desconto
integer width = 2043
integer height = 1176
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge380_alerta_desconto
integer width = 1984
integer height = 1080
string dataobject = "dw_ge380_produto_normal"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()

This.of_SetRowSelection( "if(cd_produto > 0,  if(getrow() = currentrow(), rgb(255, 0, 0), rgb(255,255,255)),  if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "if( cd_produto > 0, RGB(255,0, 0), RGB(0,0,0))", False )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge380_alerta_desconto
integer x = 1358
integer y = 1208
integer width = 357
string text = "&Confirmar"
end type

event cb_ok::clicked;call super::clicked;String ls_Responsavel

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE380_LIBERACAO_PROCEDIMENTO", Ref ls_Responsavel) Then Return -1
	
CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge380_alerta_desconto
integer x = 1760
integer y = 1208
end type

