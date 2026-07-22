HA$PBExportHeader$w_ge565_informa_lote.srw
forward
global type w_ge565_informa_lote from dc_w_response_ok_cancela
end type
end forward

global type w_ge565_informa_lote from dc_w_response_ok_cancela
integer width = 1586
integer height = 592
string title = "GE565 - Informa Lote"
end type
global w_ge565_informa_lote w_ge565_informa_lote

type variables
Long il_Produto

uo_Produto io_Produto 
end variables

on w_ge565_informa_lote.create
call super::create
end on

on w_ge565_informa_lote.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;il_Produto = Message.doubleparm

String ls_DW

io_Produto = Create uo_Produto

io_produto.of_localiza_codigo_interno(il_Produto)

If io_Produto.Localizado Then
	If Not IsNull( io_Produto.cd_grupo_psico ) Then
		ls_DW = 'dw_ge565_informa_lote_psico'
	Else
		ls_DW = 'dw_ge565_informa_lote'
	End If
	
	If Not dw_1.of_ChangeDataObject( ls_DW ) Then
		Return
	End If
	
End If
end event

event ue_postopen;call super::ue_postopen;
If Not IsNull( io_Produto.cd_grupo_psico ) Then
	dw_1.of_Populate_DDDW("nr_lote")
End If

dw_1.Object.cd_produto	[ 1 ] = io_Produto.Cd_Produto
dw_1.Object.de_produto	[ 1 ] = io_Produto.ivs_descricao_apresentacao_venda	
end event

event close;call super::close;If IsValid( io_Produto ) Then Destroy io_Produto
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge565_informa_lote
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge565_informa_lote
integer width = 1527
integer height = 364
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge565_informa_lote
integer y = 60
integer width = 1463
integer height = 276
string dataobject = "dw_ge565_informa_lote"
end type

event dw_1::ue_populate_dddw;call super::ue_populate_dddw;SetPointer( HourGlass! )

pdwc_dddw.SetTransObject( SqlCa )

If ps_Coluna = "nr_lote" Then
	pdwc_dddw.Retrieve(il_Produto)
End If

SetPointer( Arrow! )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge565_informa_lote
integer x = 905
integer y = 388
end type

event cb_ok::clicked;call super::clicked;String ls_Retorno, ls_Lote

Long ll_Qtde

dw_1.AcceptText()

ls_Lote = dw_1.Object.nr_lote [1]
ll_Qtde = dw_1.Object.qt_lote [1]

If IsNull(ls_Lote) Or trim(ls_Lote) = "" Then
	MessageBox("Ante$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o lote do produto.", Exclamation!)
	dw_1.Event ue_Pos(1, "nr_lote")
	Return -1
End If

If IsNull(ll_Qtde) Or ll_Qtde = 0 Then
	MessageBox("Ante$$HEX2$$e700e300$$ENDHEX$$o","Favor informar a qtde. do produto.", Exclamation!)
	dw_1.Event ue_Pos(1, "qt_lote")
	Return -1
End If

ls_Retorno = String( ll_Qtde, '000' ) + ls_Lote

CloseWithReturn(Parent, ls_Retorno)


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge565_informa_lote
integer x = 1239
integer y = 388
end type

