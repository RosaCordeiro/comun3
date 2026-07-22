HA$PBExportHeader$w_ge350_mensagem_logistica.srw
forward
global type w_ge350_mensagem_logistica from dc_w_response_ok_cancela
end type
end forward

global type w_ge350_mensagem_logistica from dc_w_response_ok_cancela
integer width = 1527
integer height = 728
string title = "GE350 - Mensagem Log$$HEX1$$ed00$$ENDHEX$$stica"
end type
global w_ge350_mensagem_logistica w_ge350_mensagem_logistica

type variables
str_ge350_dados_msg_logistica st
end variables

on w_ge350_mensagem_logistica.create
call super::create
end on

on w_ge350_mensagem_logistica.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;st = Message.PowerObjectParm

dw_1.Object.De_Mensagem_Logistica[1] = st.De_Mensagem_Logistica
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge350_mensagem_logistica
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge350_mensagem_logistica
integer width = 1449
integer height = 492
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge350_mensagem_logistica
integer width = 1390
integer height = 400
string dataobject = "dw_ge350_mensagem_logistica"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge350_mensagem_logistica
integer x = 832
integer y = 520
end type

event cb_ok::clicked;call super::clicked;String ls_Mensagem
String ls_Erro

dw_1.AcceptText()

ls_Mensagem = dw_1.Object.De_Mensagem_Logistica[1]

//S$$HEX1$$f300$$ENDHEX$$ valida se for inclus$$HEX1$$e300$$ENDHEX$$o da mensagem
If IsNull(st.De_Mensagem_Logistica) Then
	If IsNull(ls_Mensagem) Or Trim(ls_Mensagem) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a mensagem para a Log$$HEX1$$ed00$$ENDHEX$$stica.", Exclamation!)
		dw_1.Event ue_Pos(1, "de_mensagem_logistica")
		Return -1
	End If
	
	If LenA(Trim(ls_Mensagem)) < 5 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A mensagem para a Log$$HEX1$$ed00$$ENDHEX$$stica deve ter pelo menos 5 caracteres.", Exclamation!)
		dw_1.Event ue_Pos(1, "de_mensagem_logistica")
		Return -1
	End If
End If

If Not IsNull(st.De_Mensagem_Logistica) Then
	If ls_Mensagem <> st.De_Mensagem_Logistica Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o da mensagem para a log$$HEX1$$ed00$$ENDHEX$$stica?", Question!, YesNo!, 2) = 2 Then Return -1
	End If
End If

If Trim(ls_Mensagem) = "" Then SetNull(ls_Mensagem)

Update retirada_estoque
	Set de_mensagem_logistica = :ls_Mensagem
Where cd_filial = :st.Cd_Filial
	And nr_retirada_estoque = :st.Nr_Retirada_Estoque
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a mesagem log$$HEX1$$ed00$$ENDHEX$$stica. " + ls_Erro, StopSign!)
	Return -1
End If

SqlCa.of_Commit();

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge350_mensagem_logistica
integer x = 1166
integer y = 520
end type

