HA$PBExportHeader$w_ge646_inclui_nova_restricao.srw
forward
global type w_ge646_inclui_nova_restricao from dc_w_response_ok_cancela
end type
end forward

global type w_ge646_inclui_nova_restricao from dc_w_response_ok_cancela
integer width = 3538
integer height = 408
string title = "GE646 - Incluir Restri$$HEX2$$e700e300$$ENDHEX$$o por Endere$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge646_inclui_nova_restricao w_ge646_inclui_nova_restricao

forward prototypes
public subroutine wf_filtra_bairro ()
end prototypes

public subroutine wf_filtra_bairro ();DataWindowChild	ldwc_bairro

If dw_1.GetChild ('cd_bairro', ldwc_bairro) = 1 then
	ldwc_bairro.SetFilter ('cd_filial = ' + String (gl_cd_filial))
	ldwc_bairro.Filter    ()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da lista de bairros.")
End if

Return
end subroutine

on w_ge646_inclui_nova_restricao.create
call super::create
end on

on w_ge646_inclui_nova_restricao.destroy
call super::destroy
end on

event close;call super::close; Close(this)
end event

event ue_postopen;call super::ue_postopen;wf_filtra_bairro ()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge646_inclui_nova_restricao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge646_inclui_nova_restricao
integer width = 3488
integer height = 184
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge646_inclui_nova_restricao
integer y = 44
integer width = 3424
integer height = 108
string dataobject = "dw_ge646_cadastro_restricao"
boolean livescroll = false
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge646_inclui_nova_restricao
integer x = 2871
integer y = 192
end type

event cb_ok::clicked;call super::clicked;Integer	ll_Achou

String	ls_Id_Apresentacao
String	ls_Bairro
String	ls_Rua

dw_1.AcceptText()

ls_Id_Apresentacao	= dw_1.Object.id_apresentacao	[1]
ls_Bairro				= dw_1.Object.cd_bairro			[1]
ls_Rua					= dw_1.Object.cd_rua				[1]

Select Count(*)
	Into :ll_Achou
From wms_locais_perm_por_tp_apres
Where id_apresentacao	= :ls_Id_Apresentacao
And	cd_bairro			= :ls_Bairro
And	cd_rua				= :ls_Rua
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao consultar a restri$$HEX2$$e700e300$$ENDHEX$$o: " + SqlCa.SqlErrText)
	Return -1
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta Restri$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ existe", Exclamation!)
	Return -1
End If

Insert Into wms_locais_perm_por_tp_apres (id_apresentacao, cd_bairro, cd_rua)  
	Values (:ls_Id_Apresentacao, :ls_Bairro, :ls_Rua)  
Using SqlCa;

Choose case SqlCa.SqlCode

	Case -1
		SqlCa.of_RollBack();
		SqlCa.of_MsgdbError("Erro ao salvar restri$$HEX2$$e700e300$$ENDHEX$$o." + SqlCa.SqlErrText)
	
	Case 0
		SqlCa.of_Commit();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Restri$$HEX2$$e700e300$$ENDHEX$$o cadastrada com sucesso", Information!)

End Choose

CloseWithReturn(Parent, "OK")

Return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge646_inclui_nova_restricao
integer x = 3205
integer y = 192
end type

