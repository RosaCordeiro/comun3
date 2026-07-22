HA$PBExportHeader$w_ge575_bloqueio_pedido_uf_inclusao.srw
forward
global type w_ge575_bloqueio_pedido_uf_inclusao from dc_w_response_ok_cancela
end type
end forward

global type w_ge575_bloqueio_pedido_uf_inclusao from dc_w_response_ok_cancela
integer width = 1979
integer height = 1008
string title = "GE575 - Inclus$$HEX1$$e300$$ENDHEX$$o de bloqueio de Pedidos para Distribuidora por UF e Per$$HEX1$$ed00$$ENDHEX$$odo"
end type
global w_ge575_bloqueio_pedido_uf_inclusao w_ge575_bloqueio_pedido_uf_inclusao

type variables
uo_ge575_Bloqueio_Pedido_UF ivo_GE575
String ivs_Campo_Anterior
end variables

forward prototypes
public subroutine wf_ok ()
public subroutine wf_sel_distribuidora ()
end prototypes

public subroutine wf_ok ();str_ge575_bloqueio_pedido_uf lvst_Bloqueios
uo_ge575_Bloqueio_Pedido_UF lvo_ge575_Bloqueio_Pedido_UF

Try
	lvo_ge575_Bloqueio_Pedido_UF = Create uo_ge575_Bloqueio_Pedido_UF
	
	// Valida$$HEX2$$e700f500$$ENDHEX$$es.
	If Not lvo_ge575_Bloqueio_Pedido_UF.of_Validar_Campos_Inclusao(ref dw_1) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvo_ge575_Bloqueio_Pedido_UF.ivs_Msg, Exclamation!)
		dw_1.SetColumn(lvo_ge575_Bloqueio_Pedido_UF.ivs_SetColumn)
		dw_1.SetFocus()
		Return
	End If
	
	// Montar structure de retorno com os bloqueios.
	lvst_Bloqueios = lvo_ge575_Bloqueio_Pedido_UF.of_Montar_STR_Bloqueios(ref dw_1)
	
	CloseWithReturn(This, lvst_Bloqueios)
Finally
	Destroy lvo_ge575_Bloqueio_Pedido_UF
End Try
end subroutine

public subroutine wf_sel_distribuidora ();DataWindowChild lvdwc
If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	dw_1.SetItem(dw_1.GetRow(), 'nm_fantasia', lvdwc.GetItemString(lvdwc.GetRow(), 'nm_fantasia'))
	dw_1.SetItem(dw_1.GetRow(), 'cd_uf', 'TODAS')
	dw_1.SetItem(dw_1.GetRow(), 'cd_uf_sel', 'TODAS')
	dw_1.Post of_Populate_dddw('cd_uf')
End If
end subroutine

on w_ge575_bloqueio_pedido_uf_inclusao.create
call super::create
end on

on w_ge575_bloqueio_pedido_uf_inclusao.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Distribuidora

lvs_Distribuidora = Trim(Message.StringParm)

If lvs_Distribuidora <> '000000000' Then
	dw_1.SetItem(dw_1.GetRow(), 'cd_distribuidora', lvs_Distribuidora)
	wf_Sel_Distribuidora()
End If
end event

event open;call super::open;ivo_GE575 = Create uo_ge575_Bloqueio_Pedido_UF
end event

event close;call super::close;Destroy ivo_GE575
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge575_bloqueio_pedido_uf_inclusao
integer x = 37
integer y = 788
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge575_bloqueio_pedido_uf_inclusao
integer width = 1920
integer height = 768
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge575_bloqueio_pedido_uf_inclusao
integer width = 1883
integer height = 688
string dataobject = "dw_ge575_selecao_inclusao"
boolean ivb_ddw_multiselecao = true
string ivs_ddw_multiselecao_coluna = "cd_uf"
end type

event dw_1::itemchanged;call super::itemchanged;datawindowchild ldwc
Int lvi_For
string lvs_Sel

Choose Case dwo.Name
	// Armazenar o nome da distribuidora selecionada para mostrar na outra tela.
	Case 'cd_distribuidora'
		wf_Sel_Distribuidora()
	Case 'id_periodo_indeterminado'
		// Marcando... Bloquear data final e setar 31/12/2199
		If Data = 'S' Then
			This.Object.dh_Termino_Bloqueio.Protect=1
			This.SetItem(row, 'dh_termino_bloqueio', DateTime('31/12/2199'))
		Else // Desmarcando... Desbloquear e limpar.
			This.Object.dh_Termino_Bloqueio.Protect=0
			This.SetItem(row, 'dh_termino_bloqueio', DateTime(''))
		End If
End Choose
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_populate_dddw;call super::ue_populate_dddw;pdwc_dddw.SetTransObject(SQLCA)
pdwc_dddw.Retrieve(This.GetItemString(This.GetRow(), 'cd_distribuidora'))
pdwc_dddw.SetRow(1)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge575_bloqueio_pedido_uf_inclusao
integer x = 1298
integer y = 800
end type

event cb_ok::clicked;call super::clicked;wf_OK()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge575_bloqueio_pedido_uf_inclusao
integer x = 1632
integer y = 800
end type

