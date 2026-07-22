HA$PBExportHeader$w_ge039_email_envio_nfce.srw
forward
global type w_ge039_email_envio_nfce from dc_w_response_ok_cancela
end type
end forward

global type w_ge039_email_envio_nfce from dc_w_response_ok_cancela
integer width = 2016
integer height = 452
string title = "GE039 - E-mail envio XML"
end type
global w_ge039_email_envio_nfce w_ge039_email_envio_nfce

type variables
Boolean ibl_ESC = False
String ivs_email
String ivs_retorno
end variables

on w_ge039_email_envio_nfce.create
call super::create
end on

on w_ge039_email_envio_nfce.destroy
call super::destroy
end on

event open;call super::open;wf_centraliza_janela()

ivs_email = Message.StringParm
end event

event close;call super::close;CloseWithReturn(This,ivs_retorno)
end event

event ue_postopen;call super::ue_postopen;If dw_1.RowCount() > 0 Then
	dw_1.object.de_mail[1] = ivs_email
	dw_1.SetFocus()
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge039_email_envio_nfce
integer x = 82
integer y = 112
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge039_email_envio_nfce
integer width = 1957
integer height = 236
integer weight = 700
fontcharset fontcharset = defaultcharset!
string facename = "Verdana"
string text = "E-mail para Envio do XML"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge039_email_envio_nfce
integer width = 1906
integer height = 136
string dataobject = "dw_ge039_email_envio_nfce"
end type

event dw_1::ue_key;call super::ue_key;Choose Case Key

	Case KeyEscape!

		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Prosseguir sem enviar o e-mail?", Question!,YesNo!, 2) = 1 Then
			Close(Parent)		
		Else
			ibl_ESC = True
			dw_1.SetFocus()			
		End If
		
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge039_email_envio_nfce
integer x = 1330
integer y = 252
end type

event cb_ok::clicked;call super::clicked;String   lvs_mail
	
dw_1.AcceptText()
	
lvs_mail = Trim(dw_1.object.de_mail[1])

If IsNull(lvs_mail) or Trim(lvs_mail) = '' Then
	If ibl_ESC = False Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o e-mail para envio.", Exclamation!)
		dw_1.SetFocus()
		Return		
	Else
		ibl_ESC = False
		dw_1.SetFocus()
		Return
	End If
Else
	If ibl_ESC = False Then
		If Not gf_valida_email(lvs_mail) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe um e-mail v$$HEX1$$e100$$ENDHEX$$lido!", Exclamation!)
			dw_1.SetFocus()			
		Else
			ivs_retorno = lvs_mail
			Event Close()
		End If	
	Else
		ibl_ESC = False
		dw_1.SetFocus()
		Return
	End If		
End If
		

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge039_email_envio_nfce
integer x = 1664
integer y = 252
end type

