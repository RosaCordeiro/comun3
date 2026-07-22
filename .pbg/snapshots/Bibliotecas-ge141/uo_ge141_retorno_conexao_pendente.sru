HA$PBExportHeader$uo_ge141_retorno_conexao_pendente.sru
forward
global type uo_ge141_retorno_conexao_pendente from dc_uo_ds_base
end type
end forward

global type uo_ge141_retorno_conexao_pendente from dc_uo_ds_base
end type
global uo_ge141_retorno_conexao_pendente uo_ge141_retorno_conexao_pendente

type variables

end variables

forward prototypes
public function boolean of_solicita_retorno ()
end prototypes

public function boolean of_solicita_retorno ();Datetime ldt_Ultima_Consulta

Boolean lb_resultado
Boolean lb_EnviarEmail
Boolean lb_Delete

Integer li_PedidosPendentes

String ls_Id_Projeto
String ls_Projeto_Conexao
String ls_Nm_Projeto
String ls_Caminho
String ls_Arquivo
String ls_Anexo[]
String ls_DataFormatada

Date ldh_hoje
Date ldh_data_inicio

Long ll_Linhas_Contatos
Long ll_Linha_Contatos
Long ll_Linha_Conexao
Long ll_Linhas_Conexao
Long ll_index

String ls_erro
String ls_Texto
String ls_Texto_Email
String ls_texto2
String ls_texto2_html
String ls_texto1
String ls_Email_Contato
String ls_Email_Contato_array[]
String ls_Null[]

s_email lstr_email

// 1. Determina $$HEX1$$fa00$$ENDHEX$$ltimo dia $$HEX1$$fa00$$ENDHEX$$til
ldh_hoje = Date(gf_GetServerDate())

If Not gf_verifica_dias_uteis(1, ldh_hoje, lb_resultado) Then
	gvo_Aplicacao.Of_Grava_Log("Falha ao verificar dias $$HEX1$$fa00$$ENDHEX$$teis")
	Return False
End If

If lb_resultado = False Then 
	Return true
Else 
	lb_resultado = False
End if

// Se hoje n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ $$HEX1$$fa00$$ENDHEX$$til, retrocede at$$HEX1$$e900$$ENDHEX$$ encontrar um dia $$HEX1$$fa00$$ENDHEX$$til
ldh_data_inicio = ldh_hoje

Do While lb_resultado = False
	ldh_data_inicio = RelativeDate(ldh_data_inicio, -1)
	If Not gf_verifica_dias_uteis(1, ldh_data_inicio, lb_resultado) Then
		gvo_Aplicacao.Of_Grava_Log("Falha ao verificar dias $$HEX1$$fa00$$ENDHEX$$teis")
		Return False
	End If
Loop

ls_Caminho = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Planilha", "")

If ls_Caminho = "" Or IsNull(ls_Caminho) Then
	gvo_Aplicacao.Of_Grava_Log("Caminho para planilha n$$HEX1$$e300$$ENDHEX$$o configurado no INI.")
	Return False
End If

// Garante barra no final do caminho
If Not Right(ls_Caminho, 1) = "\" Then
	ls_Caminho += "\"
End If

//Retirar em produ$$HEX2$$e700e300$$ENDHEX$$o
//ldh_data_inicio=2025-05-22

// Formata data para nome de arquivo
ls_DataFormatada = String(ldh_data_inicio, "yyyy-mm-dd")

dc_uo_ds_base lds_conexao
dc_uo_ds_base lds_retornos
dc_uo_ds_base lds_contatos

lds_conexao		= Create dc_uo_ds_base
lds_retornos	= Create dc_uo_ds_base
lds_contatos	= Create dc_uo_ds_base

Try
	// Carregar conex$$HEX1$$f500$$ENDHEX$$es ativos
	lds_conexao.Of_ChangeDataObject('ds_ge141_lista_conexoes_ativos')
	lds_conexao.Retrieve()
	ll_Linhas_Conexao = lds_conexao.RowCount()

	For ll_Linha_Conexao = 1 To ll_Linhas_Conexao
		ls_Projeto_Conexao	= lds_conexao.Object.cd_fornecedor_envio[ll_Linha_Conexao]
		ls_Nm_Projeto			= lds_conexao.Object.de_projeto_conexao[ll_Linha_Conexao]
		ldt_Ultima_Consulta	= lds_conexao.Object.dh_ultima_consulta[ll_Linha_Conexao]
		
		// Buscar retornos pendentes
		lds_retornos.Of_ChangeDataObject('ds_ge141_busca_retorno_conexao_pendente')
		lds_retornos.Retrieve(ldh_data_inicio, ldh_data_inicio, ls_Projeto_Conexao)
		
		li_PedidosPendentes = lds_retornos.RowCount()
		
		If li_PedidosPendentes < 1 Then Continue // Pula se n$$HEX1$$e300$$ENDHEX$$o houver resultados
		
		ls_Texto = "Estamos com "+ string(li_PedidosPendentes) + " pedidos pendentes de retornos, enviados no dia " + String(ldh_data_inicio, "dd/mm/yyyy")+" pela CLAMED para a " + ls_Nm_Projeto +". "
		ls_texto1= "A $$HEX1$$fa00$$ENDHEX$$ltima consulta foi realizada em " +  String(ldt_Ultima_Consulta, "dd/mm/YYYY hh:mm") + "."
		ls_texto2 = "<font color='#FF0000'><b>IMPORTANTE!!!</b></font>" + " N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o enviados novos pedidos para estas lojas at$$HEX1$$e900$$ENDHEX$$ que os respectivos retornos sejam disponibilizados."
	
		ls_Texto_Email = "<html><body>" + &
							  ls_Texto + "<br><br>" + & 
							  ls_texto1 + "<br><br>" + &
							  "<span style='color: #FF0000; font-weight: bold;'>" + ls_texto2 + "</span>" + &
							  "</body></html>"
							
		// contatos
		lds_contatos.Of_ChangeDataObject('ds_ge141_lista_contatos')
		lds_contatos.Retrieve(ls_Projeto_Conexao)
		
		ll_Linhas_Contatos = lds_contatos.RowCount()
		
		
		If ll_Linhas_Contatos > 0 Then
			ll_index = 0
			ls_Email_Contato_array = ls_Null
			For ll_Linha_Contatos = 1 To ll_Linhas_Contatos
				ls_Email_Contato	= lds_contatos.Object.de_email[ll_Linha_Contatos]
					
				ll_index = UpperBound(ls_Email_Contato_array) + 1
				ls_Email_Contato_array[ll_index] = ls_Email_Contato					
					
			Next
		Else
			gvo_Aplicacao.Of_Grava_Log("Projeto conex$$HEX1$$e300$$ENDHEX$$o "+ls_Nm_Projeto+" sem cadastro de e-mails")
		End if

		ls_Arquivo = ls_Caminho + "PENDENCIAS_RETORNOS_PROJETO_CONEXAO_" + ls_Nm_Projeto + "_" + ls_DataFormatada + ".CSV"
		
		If lds_retornos.SaveAs(ls_Arquivo, CSV!, True) = 1 Then
			
			// Limpa os arrays
			ls_Anexo 	= ls_Null
			ls_Anexo[1] = ls_Arquivo
			
			// Enviar e-mail
			lstr_email.ps_To				= ls_Email_Contato_array
			lstr_email.ps_anexo			= ls_Anexo
			lstr_email.ps_Mensagem   	= ls_Texto_Email
			lstr_email.pb_Assinatura 	= True
			
			If gf_ge202_envia_email_padrao(348, lstr_email) Then
				lds_conexao.Object.dh_ultima_consulta[ll_Linha_Conexao] = gf_GetServerDate()
				
				If lds_conexao.Update() = 1 Then
					SqlCa.of_Commit()
				Else
					ls_erro	= SQLCA.SQLErrText
					SqlCa.of_Rollback()
					gvo_Aplicacao.Of_Grava_Log("Erro:"+ ls_erro +" ao inserir data de hoje na tabela 'conexao', coluna 'dh_ultima_consulta'")
				End if
				
			End if
			
			FileDelete(ls_Arquivo)
		
		Else
			gvo_Aplicacao.Of_Grava_Log("Falha ao salvar: " + ls_Arquivo)
		End If
	Next

Finally
	If IsValid(lds_conexao) Then Destroy lds_conexao
	If IsValid(lds_retornos) Then Destroy lds_retornos
End Try

Return True
end function

on uo_ge141_retorno_conexao_pendente.create
call super::create
end on

on uo_ge141_retorno_conexao_pendente.destroy
call super::destroy
end on

