HA$PBExportHeader$uo_ge586_envio_email_automatico.sru
forward
global type uo_ge586_envio_email_automatico from nonvisualobject
end type
end forward

global type uo_ge586_envio_email_automatico from nonvisualobject
end type
global uo_ge586_envio_email_automatico uo_ge586_envio_email_automatico

type variables

end variables

forward prototypes
public function boolean of_monta_mensagem_email (string as_msg_itens, ref string as_msg_completa)
public function boolean of_envia_email (long al_filial, string as_msg_completa, ref string al_msg_erro)
public function boolean of_verifica_processa ()
public function boolean of_envia_email_erro (long al_filial, string as_mensagem)
public subroutine _documentacao ()
public function boolean of_atualiza_data_envio_email (long al_filial, ref string al_msg_erro)
end prototypes

public function boolean of_monta_mensagem_email (string as_msg_itens, ref string as_msg_completa);String ls_Msg_Inicio, ls_Msg_Fim

ls_Msg_Inicio = 'Aten$$HEX2$$e700e300$$ENDHEX$$o, <br><br>' + &
					'Conforme motivo descrito abaixo, n$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atender $$HEX1$$e000$$ENDHEX$$ solicita$$HEX2$$e700e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o no Estoque Base.<br><br>' +&
					'<table border="2"><tbody><tr>' +&
					'<th align="center"><font size="2" face="Verdana">Filial</font></th>' +&
					'<th width="400" align="center"><font size="2" face="Verdana">Produto</font></th>' +&
					'<th width="90" align="center"><font size="2" face="Verdana">Classe Rep.</font></th>' +&
					'<th width="70" align="center"><font size="2" face="Verdana">Qt.Atual</font></th>' +&
					'<th width="70" align="center"><font size="2" face="Verdana">Qt.Solic.</font></th>' +&
					'<th width="150" align="center"><font size="2" face="Verdana" color="red"><b>Motivo</b></font></th>' +&
					'<th width="200" align="center"><font size="2" face="Verdana">Respons$$HEX1$$e100$$ENDHEX$$vel</font></th></tr><tr>' 

ls_Msg_Fim = '</tbody></table>' +&
					'<br>Para maiores informa$$HEX2$$e700f500$$ENDHEX$$es ou d$$HEX1$$fa00$$ENDHEX$$vidas, favor entrar em contato com a area de Gest$$HEX1$$e300$$ENDHEX$$o de Estoque.'

as_msg_completa = ls_Msg_Inicio + as_msg_itens + ls_Msg_Fim

Return True


end function

public function boolean of_envia_email (long al_filial, string as_msg_completa, ref string al_msg_erro);String lvs_Msg, ls_Produto, ls_Matricula, ls_Motivo, ls_Id_Situacao, ls_Assunto_Email
Long ll_Filial

s_email lst_Email

lst_Email.ps_mensagem = as_msg_completa
lst_Email.pb_assinatura = True

If Not IsNull(al_filial) Then
	If (SqlCa.Database = 'central') Then
		lst_email.ps_to[UpperBound(lst_email.ps_to)+1] = String(al_Filial, "0000") + '@clamedlocal.com.br'
//	else
//		lst_email.ps_to[1]='??????@clamed.com.br' //substituir pelo e-mail do testador
	End If
End If

If Not gf_ge202_envia_email_padrao(297, lst_email, False) Then
	al_msg_erro = 'Erro ao enviar email para Filial: ' + string(al_filial)
	Return False	
End If

Return True

end function

public function boolean of_verifica_processa ();Long ll_Linhas, ll_Linha, ll_Row, ll_Rows, ll_Nr_Solicitacao, ll_Filial, ll_Qt_Solicitacoes_Filial, ll_Qt_Solicitada, ll_Qt_Atual
String ls_Msg_Erro, ls_Produto, ls_Motivo, ls_Usuario, ls_Msg_Completa, ls_Msg_Meio = '', ls_Classe

dc_uo_ds_base lds_Qt_Solic_Filial
dc_uo_ds_base lds_Solicitacoes

lds_Qt_Solic_Filial 	= create dc_uo_ds_base
lds_Solicitacoes	= create dc_uo_ds_base

lds_Qt_Solic_Filial.of_changedataobject	( 'ds_ge586_lista_filiais_envio_email')
lds_Solicitacoes.of_changedataobject		( 'ds_ge586_lista_envio_email')

ll_Linhas = lds_Qt_Solic_Filial.Retrieve()

If ll_Linhas > 0 Then
	For ll_Linha = 1 To ll_Linhas
		SetNull(ll_Filial)
		SetNull(ls_Produto)
		SetNull(ls_Motivo)
		SetNull(ls_Usuario)
		SetNull(ll_Qt_Solicitada)
		SetNull(ll_Qt_Atual)
		SetNull(ls_Classe)
		ls_Msg_Meio = ''
		ls_Msg_Completa = ''
		
		ll_Filial = lds_Qt_Solic_Filial.Object.cd_filial[ll_Linha]
		
		lds_Solicitacoes.reset( )
		ll_Rows = lds_Solicitacoes.Retrieve(ll_Filial)
		If ll_Rows > 0 Then
			For ll_Row = 1 To ll_Rows
				ls_Produto				= lds_Solicitacoes.Object.de_produto			[ll_Row]
				ls_Motivo					= lds_Solicitacoes.Object.de_motivo			[ll_Row]
				ls_Usuario				= lds_Solicitacoes.Object.nm_usuario			[ll_Row]
				ll_Qt_Solicitada			= lds_Solicitacoes.Object.qt_solicitacao		[ll_Row]
				ll_Qt_Atual				= lds_Solicitacoes.Object.qt_estoque_base	[ll_Row]
				ls_Classe					= lds_Solicitacoes.Object.cd_classe_reposicao	[ll_Row]

				ls_Msg_Meio += '<tr><td><font size="2" face="Verdana"><center>'+ string(ll_Filial) +'</center></font></td>' +&
										'<td><font size="2" face="Verdana">'+ ls_Produto +'</font></td>' +&
										'<td><font size="2" face="Verdana">'+ ls_Classe +'</font></td>' +&
										'<td><font size="2" face="Verdana">'+ string(ll_Qt_Atual) +'</font></td>' +&
										'<td><font size="2" face="Verdana">'+ string(ll_Qt_Solicitada) +'</font></td>' +&
										'<td><font size="2" face="Verdana" color="red"><b>'+ ls_Motivo +'</b></font></td>' +&
										'<td><font size="2" face="Verdana">'+ ls_Usuario +'</font></td></tr>'
			Next
			
			//Une strings para mensagem completa
			If Not of_monta_mensagem_email(ls_Msg_Meio, Ref ls_Msg_Completa) Then Continue
			
			//Envia o email para a filial
			If Not of_Envia_Email(ll_Filial, ls_Msg_Completa, Ref ls_Msg_Erro) Then 
				of_Envia_Email_Erro(ll_Filial, ls_Msg_Erro)
				Continue
			End If
			
			//Atualiza data hora do envio do email
			If Not of_Atualiza_Data_Envio_Email(ll_Filial, Ref ls_Msg_Erro) Then
				of_Envia_Email_Erro(ll_Filial, ls_Msg_Erro)
				Continue
			End If
			
		ElseIf ll_Rows < 0 Then
			ls_Msg_Erro = "Erro ao carregar solicita$$HEX2$$e700f500$$ENDHEX$$es para envio de email da Filial: "+ String(ll_Filial)
			of_Envia_Email_Erro(ll_Filial, ls_Msg_Erro)
			Continue
		End If
		
	Next
	
Else
	ls_Msg_Erro = "Sem filiais para envio de email"
	Return False
End If

Destroy(lds_Qt_Solic_Filial)
Destroy(lds_Solicitacoes)

Return True
end function

public function boolean of_envia_email_erro (long al_filial, string as_mensagem);String lvs_Msg

s_email lst_Email

lvs_Msg = "Aten$$HEX2$$e700e300$$ENDHEX$$o, <br><br>" + &
               "Descri$$HEX2$$e700e300$$ENDHEX$$o: "+as_mensagem+"<br>" + "Erro processo da GE586. Filial: " + String(al_Filial)

lst_Email.ps_mensagem = lvs_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao( 298 , lst_Email ) Then
   Return False	
End If

Return True
end function

public subroutine _documentacao ();/*
Objeto para envio automatico de email quando a solicita$$HEX2$$e700e300$$ENDHEX$$o de EB $$HEX1$$e900$$ENDHEX$$ rejeitada. Envia somente uma vez!

Tabelas:
	resumo_reposicao_estoque_solic
	usuario
	produto_geral


*/
end subroutine

public function boolean of_atualiza_data_envio_email (long al_filial, ref string al_msg_erro);Datetime ldh_Agora

ldh_Agora = datetime(String(gf_getserverdate(), 'yyyy-mm-dd hh:mm'))

UPDATE resumo_reposicao_estoque_solic
SET dh_envio_email = :ldh_Agora
WHERE
    cd_filial = :al_Filial
    AND id_situacao = 'RS'
	AND dh_envio_email IS NULL
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		SqlCa.of_commit( )
		Return True
	Case -1
		SqlCa.of_rollback( )
		al_msg_erro = 'Erro ao atualizar data de envio do email.'
		Return False
End Choose


end function

on uo_ge586_envio_email_automatico.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge586_envio_email_automatico.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

