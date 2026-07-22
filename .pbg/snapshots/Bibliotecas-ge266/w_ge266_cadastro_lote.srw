HA$PBExportHeader$w_ge266_cadastro_lote.srw
forward
global type w_ge266_cadastro_lote from dc_w_response_ok_cancela
end type
end forward

global type w_ge266_cadastro_lote from dc_w_response_ok_cancela
integer width = 1952
integer height = 560
string title = "GE266 - Cadastro de Lote de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compras"
boolean controlmenu = true
long backcolor = 80269524
end type
global w_ge266_cadastro_lote w_ge266_cadastro_lote

type variables
uo_fornecedor ivo_forn
uo_parametro_geral ivo_parametro_geral

long ivl_lote
end variables

on w_ge266_cadastro_lote.create
call super::create
end on

on w_ge266_cadastro_lote.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

ivo_forn            = Create uo_Fornecedor
ivo_parametro_geral = Create uo_Parametro_Geral

If Not IsNull(ivl_Lote) Then
	dw_1.Retrieve(ivl_Lote)
End If
end event

event close;call super::close;Destroy(ivo_Forn)
Destroy(ivo_Parametro_Geral)
end event

event open;call super::open;ivl_Lote = Message.DoubleParm	


end event

event ue_save;call super::ue_save;If AncestorReturnValue <> -1 Then
	Close(This)
End If

Return AncestorReturnValue
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge266_cadastro_lote
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge266_cadastro_lote
integer y = 0
integer width = 1893
integer height = 332
integer weight = 700
string facename = "Verdana"
long backcolor = 80269524
string text = "Lote"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge266_cadastro_lote
integer x = 46
integer y = 52
integer width = 1861
integer height = 244
string dataobject = "dw_ge266_manutencao_lote"
end type

event dw_1::ue_key;String lvs_Nulo

If key = KeyEnter! Then
	If This.GetColumnName() = 'nm_razao_social' Then
		
		ivo_Forn.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Forn.Localizado Then
			This.Object.cd_fornecedor  [1] = ivo_Forn.cd_fornecedor
			This.Object.nm_razao_social[1] = ivo_Forn.nm_razao_social
		Else
			SetNull(lvs_Nulo)
			This.Object.cd_fornecedor  [1] = lvs_Nulo
			This.Object.nm_razao_social[1] = lvs_Nulo
			cb_ok.Enabled = False
		End If
		
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;cb_ok.Enabled = True

If This.GetColumnName() = 'nm_razao_social' Then
	If Not IsNull(data) and data <> "" Then
		If data <> ivo_Forn.nm_razao_social Then
			Return 1
		End If
	Else
		This.Object.cd_fornecedor  [1] = ""
		This.Object.nm_razao_social[1] = ""
	End If
End If




end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Forn) Then
	This.Object.Cd_Fornecedor    [1] = ivo_Forn.Cd_Fornecedor
	This.Object.Nm_razao_social  [1] = ivo_Forn.Nm_Razao_Social
End If
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long lvl_Lote 
Long ll_Motivo

String lvs_Fornecedor

This.AcceptText()

lvl_Lote       		= This.Object.nr_lote     		 			[1]
lvs_Fornecedor = This.Object.cd_fornecedor			[1]
ll_Motivo			= This.Object.cd_motivo_devolucao	[1]

If IsNull(lvs_Fornecedor) or lvs_Fornecedor = "" Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor.", Information!)
	This.SetFocus()
	This.Event ue_Pos(1, 'nm_razao_social')
	cb_ok.Enabled = False
	Return -1
End If

If IsNull( ll_Motivo ) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da devolu$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	This.SetFocus()
	This.Event ue_Pos(1, 'cd_motivo_devolucao')
	cb_ok.Enabled = False
	Return -1
End If

If IsNull(lvl_Lote) Then
	If Not ivo_Parametro_Geral.of_Proximo_Sequencial("NR_ULTIMO_LOTE_DEVOLUCAO", Ref lvl_Lote) Then
		Return -1
	Else
		This.Object.nr_lote[1] = lvl_Lote
	End If
End If

This.Object.dh_Registro              			[1] = gvo_Parametro.of_DH_Movimentacao()
This.Object.nr_matricula_responsavel 	[1] = gvo_Aplicacao.ivo_Seguranca.nr_matricula
This.Object.vl_lote				              	[1] = 0.00
This.Object.id_situacao		              	[1] = 'A'

Return 1

end event

event dw_1::editchanged;call super::editchanged;cb_ok.Enabled = True

end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge266_cadastro_lote
integer x = 1184
integer y = 352
integer width = 357
string facename = "Verdana"
boolean enabled = false
string text = "&Confirmar"
boolean default = false
end type

event cb_ok::clicked;Parent.Event ue_Save()


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge266_cadastro_lote
integer x = 1559
integer y = 352
integer width = 357
string facename = "Verdana"
end type

