HA$PBExportHeader$w_ge202_envia_xml_email.srw
forward
global type w_ge202_envia_xml_email from dc_w_response_ok_cancela
end type
end forward

global type w_ge202_envia_xml_email from dc_w_response_ok_cancela
integer width = 1669
integer height = 428
string title = "GE202 - Enviar XML"
long backcolor = 67108864
end type
global w_ge202_envia_xml_email w_ge202_envia_xml_email

on w_ge202_envia_xml_email.create
call super::create
end on

on w_ge202_envia_xml_email.destroy
call super::destroy
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge202_envia_xml_email
integer x = 27
integer y = 220
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge202_envia_xml_email
integer y = 8
integer width = 1605
integer height = 192
integer weight = 700
string facename = "Verdana"
string text = "E-mail Destinat$$HEX1$$e100$$ENDHEX$$rio"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge202_envia_xml_email
integer x = 59
integer y = 84
integer width = 1536
integer height = 76
string dataobject = "dw_ge202_email_destinatario"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge202_envia_xml_email
integer x = 983
integer y = 220
string facename = "Verdana"
end type

event cb_ok::clicked;call super::clicked;String ls_Anexo[], ls_CC[], ls_TO[], ls_Arquivos[]
String ls_chave
Long ll_Retorno

dw_1.AcceptText()

If IsNull( dw_1.Object.de_email[1] ) Or Trim( dw_1.Object.de_email[1] ) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o e-mail do destinat$$HEX1$$e100$$ENDHEX$$rio.")
	dw_1.Event ue_Pos(1, "de_email")
	Return -1
End If

ls_TO[1] = dw_1.Object.de_email [ 1 ]

ls_chave = message.StringParm

ll_Retorno = gf_dir_list('C:\XMLTemp', ls_chave + '*.xml', 0, Ref ls_Arquivos[] )

Choose Case ll_Retorno 
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao listar o diret$$HEX1$$f300$$ENDHEX$$rio: 'C:\XMLTemp\' ")
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum XML localizado no diret$$HEX1$$f300$$ENDHEX$$rio: 'C:\XMLTemp\' ")
	Case Else
				
		ls_Anexo[1] = 'C:\XMLTemp\' + ls_Arquivos[1]
		
		//Envia email	
		uo_smtp lo_Email
		lo_Email = Create uo_smtp
		lo_Email.ib_grava_log_db = False
		
		lo_Email.of_envia_email_anexo('CLAMED Sistemas', &
						  'nfe@clamed.com.br', &
						  'XML - CIA LATINO AMERICANA DE MEDICAMENTOS', &
						  'O arquivo est$$HEX1$$e100$$ENDHEX$$ anexo.', &
						   ls_TO, &
						   ls_CC, &
						   ls_Anexo)
							
		If Not FileDelete( ls_Anexo[1] ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao remover o arquivo: " + ls_Anexo[1] ) 
		End If
		
		Destroy lo_Email

		CloseWithReturn(Parent, 'S')

End Choose



end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge202_envia_xml_email
integer x = 1317
integer y = 220
string facename = "Verdana"
end type

