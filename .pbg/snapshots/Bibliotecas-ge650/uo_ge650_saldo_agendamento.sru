HA$PBExportHeader$uo_ge650_saldo_agendamento.sru
forward
global type uo_ge650_saldo_agendamento from nonvisualobject
end type
end forward

global type uo_ge650_saldo_agendamento from nonvisualobject
end type
global uo_ge650_saldo_agendamento uo_ge650_saldo_agendamento

forward prototypes
public function boolean of_envia_email_log (string as_erro, string as_chave, string as_processo)
public function boolean of_consulta_parametro_dias (ref integer as_dias_desconsiderados, ref integer as_dias_busca, ref integer as_dias_aviso, ref string as_erro)
public function boolean of_atualiza_saldo_desconsiderado ()
public function boolean of_verifica_parametro_dias (ref date adh_data_fim, ref string as_erro)
public function boolean of_envia_email_prox_saldo_desconsiderado ()
public function boolean of_envia_email_saldo_desconsiderado (date adh_data_inicio, date adh_data_fim, ref string as_erro)
public function boolean of_envia_email_entrega_atrasada ()
end prototypes

public function boolean of_envia_email_log (string as_erro, string as_chave, string as_processo);String lvs_data_envio
String ls_Texto_email
String ls_Texto01
String ls_Texto02

	
s_email str 

ls_Texto01 = "Ocorreram erros na execu$$HEX2$$e700e300$$ENDHEX$$o da tarefa ES - ATUALIZACAO EMPURRADOS NAO FATURADOS "

If as_processo = 'of_consulta_parametro_dias' Then
	ls_Texto02 = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_consulta_parametro_dias, uo_ge650_saldo_agendamento"
Else
	ls_Texto02 = "Erro:" + 	as_erro + ", na chave de acesso: " + as_chave + ", Processo: " + as_processo
End if

lvs_data_envio = String ( RelativeDate (Date (gf_GetServerDate()),-0), "yyyy-mm-dd")
		
ls_Texto_Email = 	"<HTML>"+&
										"<BODY>"+&
										"<BR>"+&										
										"<TABLE border=0>"+&
										"<TR>"+& 
										"<TD>" + ls_Texto01 + "</TD>"+&	
										"</TR>"+& 									
										"<TR>"+& 
										"<TD>" + ls_Texto02 + "</TD>"+&	
										"</TR>"										

ls_Texto_Email		= ls_Texto_Email +"</TABLE></BODY></HTML>" 
str.ps_Mensagem	= ls_Texto_Email	
str.pb_Assinatura	= True
gf_ge202_envia_email_padrao(0, str)

Return True 
end function

public function boolean of_consulta_parametro_dias (ref integer as_dias_desconsiderados, ref integer as_dias_busca, ref integer as_dias_aviso, ref string as_erro);String ls_dias_parametro_agendamento
String ls_dias_parametro_busca
String ls_dias_parametro_aviso

select vl_parametro
Into	:ls_dias_parametro_agendamento
	from parametro_geral 
	where cd_parametro ='NR_DIAS_AGENDAMENTO_ENTREGA_CD'
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'NR_DIAS_AGENDAMENTO_ENTREGA_CD' na tabela parametro_geral "
		Return False
	
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'NR_DIAS_AGENDAMENTO_ENTREGA_CD' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
		
End Choose

select vl_parametro
Into	:ls_dias_parametro_busca
	from parametro_geral 
	where cd_parametro ='NR_DIAS_MAX_DESCONSIDERAR_AGD'
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'NR_DIAS_MAX_DESCONSIDERAR_AGD' na tabela parametro_geral "
		Return False
	
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'NR_DIAS_MAX_DESCONSIDERAR_AGD' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
		
End Choose

select vl_parametro
Into	:ls_dias_parametro_aviso
	from parametro_geral 
	where cd_parametro ='NR_DIAS_LIMITE_LEMBRAR_AGD_ENTREGA'
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'NR_DIAS_LIMITE_LEMBRAR_AGD_ENTREGA' na tabela parametro_geral "
		Return False
	
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'NR_DIAS_LIMITE_LEMBRAR_AGD_ENTREGA' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
		
End Choose

as_dias_aviso				= integer(ls_dias_parametro_aviso)
as_dias_desconsiderados = integer(ls_dias_parametro_agendamento)
as_dias_busca				= integer(ls_dias_parametro_busca)

Return true
end function

public function boolean of_atualiza_saldo_desconsiderado ();Boolean	lb_Resultado

Date		ldt_inicio_desconsiderar
Date		ldt_Datas_consulta []
Datetime	ldt_Libera_Agendamento
Date		ldt_hoje
Date		ldt_data_fim
Date		ldt_data_inicio

Integer	li_Dias_desconsiderar
Integer	li_Count_dias_uteis
Integer	li_Dias_maximo
Integer	li_Dias_aviso

Long		ll_Linha
Long		ll_Linhas

String	ls_Erro
String	ls_Id_Entregue
String	ls_Chave_Acesso

ldt_hoje = Date(gf_GetServerDate())

// Verifica se $$HEX1$$e900$$ENDHEX$$ dia $$HEX1$$fa00$$ENDHEX$$til, se n$$HEX1$$e300$$ENDHEX$$o for retorna true aqui e n$$HEX1$$e300$$ENDHEX$$o segue com o processo
If not gf_verifica_dias_uteis(1, ldt_Hoje, lb_Resultado) then 
	of_envia_email_log ('N$$HEX1$$e300$$ENDHEX$$o foi possivel fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o dos dias uteis','0','gf_verifica_dias_uteis')
	Return False	
End if

If Not lb_Resultado Then
    Return True
End If

//teste de mesa com valor li_Dias_desconsiderar=2
If Not of_consulta_parametro_dias(ref li_Dias_desconsiderar,ref li_Dias_maximo,ref li_Dias_aviso  ,ref ls_erro) Then
	of_envia_email_log (ls_erro,'0','of_consulta_parametro_dias')
	Return False
End if

ldt_data_fim = ldt_hoje

//ldt_inicio_desconsiderar = 08/03/2025
ldt_inicio_desconsiderar = RelativeDate(ldt_hoje, - li_Dias_desconsiderar)

li_Count_dias_uteis = 0 

//verificar dias uteis
Do while li_Count_dias_uteis <= li_Dias_desconsiderar 

If not gf_verifica_dias_uteis(1, ldt_Hoje, lb_Resultado) then 
	of_envia_email_log ('N$$HEX1$$e300$$ENDHEX$$o foi possivel fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o dos dias uteis','0','gf_verifica_dias_uteis')
	Return False	
End if

	If lb_resultado = True Then
		ldt_Datas_consulta[UpperBound(ldt_Datas_consulta) + 1] = ldt_data_fim
		li_Count_dias_uteis ++  
	End If
	 
	ldt_data_fim = RelativeDate(ldt_data_fim, -1)
Loop

//data inicial da consulta $$HEX1$$e900$$ENDHEX$$ a data de fim - os dias parametrizados
ldt_data_inicio = RelativeDate(ldt_data_fim, - li_Dias_maximo)

dc_uo_ds_base lds_agendamento
lds_agendamento = Create dc_uo_ds_base
lds_agendamento.Of_ChangeDataObject('ds_ge650_saldo_agendamento')
lds_agendamento.Retrieve('N',ldt_data_inicio,ldt_data_fim)

ll_Linhas = lds_agendamento.RowCount()

For ll_Linha = 1 To ll_Linhas
	
	ls_Id_Entregue					= lds_agendamento.Object.id_entregue_cd					[ll_Linha]
	ldt_Libera_Agendamento		= lds_agendamento.Object.dh_liberacao_agendamento		[ll_Linha]
	ls_Chave_Acesso				= lds_agendamento.Object.de_chave_acesso					[ll_Linha]

	If date(ldt_Libera_Agendamento) < ldt_data_fim Then
		lds_agendamento.SetItem(ll_Linha, "id_entregue_cd", "D")
		lds_agendamento.SetItem(ll_Linha, "dh_desconsidera_rateio", ldt_hoje)
		
		If lds_agendamento.Update() = 1 Then
			 SqlCa.of_Commit()
		Else
			 ls_erro = SQLCA.SQLErrText
			 SqlCa.of_Rollback()
			 of_envia_email_log (ls_erro,ls_Chave_Acesso,'Commit do Cancelamento')
			 Return False
		End If
	Else
	End if	
Next

//chamar o email do descancelamento 
//If Not of_envia_email_saldo_desconsiderado(ldt_data_inicio,ldt_data_fim,ref ls_erro) Then
//	of_envia_email_log (ls_erro,'0','of_envia_email_saldo_desconsiderado')
//	Return False
//End if

Return True
end function

public function boolean of_verifica_parametro_dias (ref date adh_data_fim, ref string as_erro);Boolean	lb_Resultado

Date		ldt_inicio_desconsiderar
Date		ldt_Datas_consulta []

Date		ldt_hoje
Date		ldt_data_fim
Date		ldt_data_inicio

Integer	li_Dias_desconsiderar
Integer	li_Count_dias_uteis
Integer	li_Dias_maximo
Integer	li_Dias_aviso

ldt_hoje = Date(gf_GetServerDate())

// Verifica se $$HEX1$$e900$$ENDHEX$$ dia $$HEX1$$fa00$$ENDHEX$$til, se n$$HEX1$$e300$$ENDHEX$$o for retorna true aqui e n$$HEX1$$e300$$ENDHEX$$o segue com o processo
If not gf_verifica_dias_uteis(1, ldt_Hoje, lb_Resultado) then 
	of_envia_email_log ('N$$HEX1$$e300$$ENDHEX$$o foi possivel fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o dos dias uteis','0','gf_verifica_dias_uteis')
	Return False	
End if

If Not lb_Resultado Then
    Return True
End If

//teste de mesa com valor li_Dias_desconsiderar=2
If Not of_consulta_parametro_dias(ref li_Dias_desconsiderar,ref li_Dias_maximo,ref li_Dias_aviso  ,ref as_erro) Then
	of_envia_email_log (as_erro,'0','of_consulta_parametro_dias')
	Return False
End if

ldt_data_fim = ldt_hoje

//ldt_inicio_desconsiderar = 08/03/2025
ldt_inicio_desconsiderar = RelativeDate(ldt_hoje, - li_Dias_desconsiderar)

li_Count_dias_uteis = 0 

//verificar dias uteis
Do while li_Count_dias_uteis <= li_Dias_desconsiderar 

If not gf_verifica_dias_uteis(1, ldt_Hoje, lb_Resultado) then 
	of_envia_email_log ('N$$HEX1$$e300$$ENDHEX$$o foi possivel fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o dos dias uteis','0','gf_verifica_dias_uteis')
	Return False	
End if

    If lb_resultado = True Then
        ldt_Datas_consulta[UpperBound(ldt_Datas_consulta) + 1] = ldt_data_fim
		  li_Count_dias_uteis ++  
    End If
	 
	 ldt_data_fim = RelativeDate(ldt_data_fim, -1)
Loop

//data inicial da consulta $$HEX1$$e900$$ENDHEX$$ a data de fim - os dias parametrizados
ldt_data_inicio = RelativeDate(ldt_data_fim, - li_Dias_maximo)

adh_data_fim = ldt_data_fim 

Return True
end function

public function boolean of_envia_email_prox_saldo_desconsiderado ();Boolean lb_Resultado

Date ldh_data_inicio
Date ldh_data_fim

Long		ll_Linhas
Long		ll_Linha
Integer	li_tentativas

Long ll_Qt_tributada

String ls_Nulo []
String ls_Texto_Email
String ls_Dados_Email
String ls_Email_Comprador
String ls_Matricula_Comprador
String ls_Matricula_Anterior = ""
String ls_Erro

If Not of_verifica_parametro_dias(ldh_data_inicio,ls_Erro) Then
	of_envia_email_log (ls_erro,'0','of_verifica_parametro_dias')
	Return False
End if

//verificar dias uteis
Do while lb_resultado = False and li_tentativas < 6

If not gf_verifica_dias_uteis(1, ldh_data_inicio, lb_Resultado) then 
	of_envia_email_log ('N$$HEX1$$e300$$ENDHEX$$o foi possivel fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o dos dias uteis','0','gf_verifica_dias_uteis')
	Return False	
End if

    If lb_resultado = False Then
			ldh_data_inicio = RelativeDate(ldh_data_inicio, + 1)
			li_tentativas++
    End If	 
Loop

If li_tentativas > 6 Then
	of_envia_email_log (ls_erro,'0','gf_verifica_dias_uteis')
	Return False
End if 

ldh_data_fim = RelativeDate(ldh_data_inicio, + 1)

s_email str

dc_uo_ds_base lds_saldo_desconsiderado
lds_saldo_desconsiderado = Create dc_uo_ds_base
lds_saldo_desconsiderado.of_ChangeDataObject("ds_ge650_saldo_agendamento")
ll_Linhas = lds_saldo_desconsiderado.Retrieve('N', ldh_data_inicio, ldh_data_fim)

If ll_Linhas > 0 Then     
    For ll_Linha = 1 to ll_Linhas 
        ls_Matricula_Comprador = Trim(lds_saldo_desconsiderado.Object.nr_matricula_comprador[ll_Linha])

        // Se o comprador mudou e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ o primeiro registro, envia o e-mail antes de iniciar um novo
        If ls_Matricula_Comprador <> ls_Matricula_Anterior And ls_Matricula_Anterior <> "" Then
            // Envia o e-mail antes de processar o novo comprador
            If ls_Dados_Email <> "" Then
                ls_Texto_Email = "<HTML><BODY><H3>Relat$$HEX1$$f300$$ENDHEX$$rio dos produtos que ser$$HEX1$$e300$$ENDHEX$$o desconsiderados no Saldo de Agendamento a partir do pr$$HEX1$$f300$$ENDHEX$$ximo dia $$HEX1$$fa00$$ENDHEX$$til.</H3>"
                ls_Texto_Email += "<TABLE border='1' cellpadding='2' cellspacing='0' style='border-collapse: collapse;'>"
                ls_Texto_Email += ls_Dados_Email
                ls_Texto_Email += "</TABLE><BR>"
                ls_Texto_Email += "<P>Relat$$HEX1$$f300$$ENDHEX$$rio dos produtos com saldo em tr$$HEX1$$e200$$ENDHEX$$nsito que n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o mais considerados no rateio do E.C. a partir do pr$$HEX1$$f300$$ENDHEX$$ximo dia $$HEX1$$fa00$$ENDHEX$$til.</P>"
                ls_Texto_Email += "</BODY></HTML>"

                ls_Email_Comprador = ls_Matricula_Anterior + "@clamed.com.br" 
					// ls_Email_Comprador = 	"giovani.santos@clamed.com.br"
                // Envio do e-mail
					 str.ps_to = ls_Nulo
                str.ps_to[UpperBound(str.ps_to)+1] = ls_Email_Comprador
                str.ps_Mensagem = ls_Texto_Email 
                str.pb_Assinatura = True
                gf_ge202_envia_email_padrao(344, str)
            End If

            ls_Dados_Email = ""
        End If 

        // Adiciona o cabe$$HEX1$$e700$$ENDHEX$$alho apenas no in$$HEX1$$ed00$$ENDHEX$$cio de cada novo comprador
        If ls_Matricula_Comprador <> ls_Matricula_Anterior Or ls_Dados_Email = "" Then
            ls_Dados_Email = "<tr bgcolor='#ffff66'>" + &
                            "<th align='center'>Data Emiss$$HEX1$$e300$$ENDHEX$$o</th>" + &
                            "<th align='center'>C$$HEX1$$f300$$ENDHEX$$d. Produto</th>" + &
                            "<th align='center'>Qt. Tributada</th>" + &
                            "<th align='center'>Fornecedor</th>" + &
                            "<th align='center'>Pedido Central</th>" + &
                            "<th align='center'>NF</th>" + &
                            "<th align='center'>Esp$$HEX1$$e900$$ENDHEX$$cie</th>" + &
                            "<th align='center'>S$$HEX1$$e900$$ENDHEX$$rie</th>" + &
                            "<th align='center'>Chave Acesso</th>" + &
                            "</tr>"
        End If

        // Adiciona os produtos do comprador atual
		  ll_Qt_tributada	= lds_saldo_desconsiderado.Object.qt_tributada[ll_Linha]
		  
        ls_Dados_Email += "<tr>" + &
                          "<td>" + String(lds_saldo_desconsiderado.Object.dh_emissao[ll_Linha], "dd/mm/yyyy") + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.cd_produto[ll_Linha]) + "</td>" + &
								   "<td align='right'>" + String(ll_Qt_tributada) + "</td>" + &
                          "<td>" + Left(Trim(lds_saldo_desconsiderado.Object.nm_razao_social[ll_Linha]), 40) + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.nr_pedido_central[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.nr_nf[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + Trim(lds_saldo_desconsiderado.Object.de_especie[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + Trim(lds_saldo_desconsiderado.Object.de_serie[ll_Linha]) + "</td>" + &
                          "<td>" + Trim(lds_saldo_desconsiderado.Object.de_chave_acesso[ll_Linha]) + "</td>" + &
                          "</tr>"
								  
        ls_Matricula_Anterior = ls_Matricula_Comprador
    Next

    // Enviar e-mail para o $$HEX1$$fa00$$ENDHEX$$ltimo comprador processado
    If ls_Matricula_Anterior <> "" And ls_Dados_Email <> "" Then
        ls_Texto_Email = "<HTML><BODY><H3>Relat$$HEX1$$f300$$ENDHEX$$rio dos produtos que ser$$HEX1$$e300$$ENDHEX$$o desconsiderados no Saldo de Agendamento a partir do pr$$HEX1$$f300$$ENDHEX$$ximo dia $$HEX1$$fa00$$ENDHEX$$til.</H3>"
        ls_Texto_Email += "<TABLE border='1' cellpadding='2' cellspacing='0' style='border-collapse: collapse;'>"
        ls_Texto_Email += ls_Dados_Email
        ls_Texto_Email += "</TABLE><BR>"
        ls_Texto_Email += "<P>Relat$$HEX1$$f300$$ENDHEX$$rio dos produtos com saldo em tr$$HEX1$$e200$$ENDHEX$$nsito que n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o mais considerados no rateio do E.C. a partir do pr$$HEX1$$f300$$ENDHEX$$ximo dia $$HEX1$$fa00$$ENDHEX$$til.</P>"
        ls_Texto_Email += "</BODY></HTML>"

        ls_Email_Comprador = ls_Matricula_Anterior + "@clamed.com.br"
		//  ls_Email_Comprador = 	"giovani.santos@clamed.com.br"
			
        // Envio do e-mail
		  str.ps_to = ls_Nulo
        str.ps_to[UpperBound(str.ps_to)+1] = ls_Email_Comprador
        str.ps_Mensagem = ls_Texto_Email 
        str.pb_Assinatura = True
        gf_ge202_envia_email_padrao(344, str)
    End If
End If 

Destroy (lds_saldo_desconsiderado)
Return True


end function

public function boolean of_envia_email_saldo_desconsiderado (date adh_data_inicio, date adh_data_fim, ref string as_erro);Long ll_Linhas
Long ll_Linha
Long ll_Qt_tributada

String ls_Nulo []
String ls_Texto_Email
String ls_Dados_Email
String ls_Email_Comprador
String ls_Matricula_Comprador
String ls_Matricula_Anterior = ""

s_email str

dc_uo_ds_base lds_saldo_desconsiderado
lds_saldo_desconsiderado = Create dc_uo_ds_base
lds_saldo_desconsiderado.of_ChangeDataObject("ds_ge650_saldo_agendamento")
ll_Linhas = lds_saldo_desconsiderado.Retrieve('D', adh_data_inicio, adh_data_fim)

If ll_Linhas > 0 Then     
    For ll_Linha = 1 to ll_Linhas 
        ls_Matricula_Comprador = Trim(lds_saldo_desconsiderado.Object.nr_matricula_comprador[ll_Linha])

        // Se o comprador mudou e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ o primeiro registro, envia o e-mail antes de iniciar um novo
        If ls_Matricula_Comprador <> ls_Matricula_Anterior And ls_Matricula_Anterior <> "" Then
            // Envia o e-mail antes de processar o novo comprador
            If ls_Dados_Email <> "" Then
                ls_Texto_Email = "<HTML><BODY><H3>Relat$$HEX1$$f300$$ENDHEX$$rio dos produtos desconsiderados no Saldo de Agendamento</H3>"
                ls_Texto_Email += "<TABLE border='1' cellpadding='2' cellspacing='0' style='border-collapse: collapse;'>"
                ls_Texto_Email += ls_Dados_Email
                ls_Texto_Email += "</TABLE><BR>"
                ls_Texto_Email += "<P>Relat$$HEX1$$f300$$ENDHEX$$rio dos produtos com saldo em tr$$HEX1$$e200$$ENDHEX$$nsito que n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o mais considerados no rateio do estoque central.</P>"
                ls_Texto_Email += "</BODY></HTML>"

                ls_Email_Comprador = ls_Matricula_Anterior + "@clamed.com.br" 

                // Envio do e-mail
					 str.ps_to = ls_Nulo
                str.ps_to[UpperBound(str.ps_to)+1] = ls_Email_Comprador
                str.ps_Mensagem = ls_Texto_Email 
                str.pb_Assinatura = True
                gf_ge202_envia_email_padrao(344, str)
            End If

            ls_Dados_Email = ""
        End If 

        // Adiciona o cabe$$HEX1$$e700$$ENDHEX$$alho apenas no in$$HEX1$$ed00$$ENDHEX$$cio de cada novo comprador
        If ls_Matricula_Comprador <> ls_Matricula_Anterior Or ls_Dados_Email = "" Then
            ls_Dados_Email = "<tr bgcolor='#ffff66'>" + &
                            "<th align='center'>Data Emiss$$HEX1$$e300$$ENDHEX$$o</th>" + &
                            "<th align='center'>C$$HEX1$$f300$$ENDHEX$$d. Produto</th>" + &
                            "<th align='center'>Qt. Tributada</th>" + &
                            "<th align='center'>Fornecedor</th>" + &
                            "<th align='center'>Pedido Central</th>" + &
                            "<th align='center'>NF</th>" + &
                            "<th align='center'>Esp$$HEX1$$e900$$ENDHEX$$cie</th>" + &
                            "<th align='center'>S$$HEX1$$e900$$ENDHEX$$rie</th>" + &
                            "<th align='center'>Chave Acesso</th>" + &
                            "</tr>"
        End If

        // Adiciona os produtos do comprador atual
		  ll_Qt_tributada	= lds_saldo_desconsiderado.Object.qt_tributada[ll_Linha]
		  
        ls_Dados_Email += "<tr>" + &
                          "<td>" + String(lds_saldo_desconsiderado.Object.dh_emissao[ll_Linha], "dd/mm/yyyy") + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.cd_produto[ll_Linha]) + "</td>" + &
								   "<td align='right'>" + String(ll_Qt_tributada) + "</td>" + &
                          "<td>" + Left(Trim(lds_saldo_desconsiderado.Object.nm_razao_social[ll_Linha]), 40) + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.nr_pedido_central[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.nr_nf[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + Trim(lds_saldo_desconsiderado.Object.de_especie[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + Trim(lds_saldo_desconsiderado.Object.de_serie[ll_Linha]) + "</td>" + &
                          "<td>" + Trim(lds_saldo_desconsiderado.Object.de_chave_acesso[ll_Linha]) + "</td>" + &
                          "</tr>"
								  
        ls_Matricula_Anterior = ls_Matricula_Comprador
    Next

    // Enviar e-mail para o $$HEX1$$fa00$$ENDHEX$$ltimo comprador processado
    If ls_Matricula_Anterior <> "" And ls_Dados_Email <> "" Then
        ls_Texto_Email = "<HTML><BODY><H3>Relat$$HEX1$$f300$$ENDHEX$$rio dos produtos desconsiderados no Saldo de Agendamento</H3>"
        ls_Texto_Email += "<TABLE border='1' cellpadding='2' cellspacing='0' style='border-collapse: collapse;'>"
        ls_Texto_Email += ls_Dados_Email
        ls_Texto_Email += "</TABLE><BR>"
        ls_Texto_Email += "<P>Relat$$HEX1$$f300$$ENDHEX$$rio dos produtos com saldo em tr$$HEX1$$e200$$ENDHEX$$nsito que n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o mais considerados no rateio do estoque central.</P>"
        ls_Texto_Email += "</BODY></HTML>"

        ls_Email_Comprador = ls_Matricula_Anterior + "@clamed.com.br"

        // Envio do e-mail
		  str.ps_to = ls_Nulo
        str.ps_to[UpperBound(str.ps_to)+1] = ls_Email_Comprador
        str.ps_Mensagem = ls_Texto_Email 
        str.pb_Assinatura = True
        gf_ge202_envia_email_padrao(344, str)
    End If
End If 

Destroy (lds_saldo_desconsiderado)
Return True
end function

public function boolean of_envia_email_entrega_atrasada ();Boolean lb_Resultado

Date ldh_data_inicio
Date ldh_data_fim

Long		ll_Linhas
Long		ll_Linha
Integer	li_tentativas

Long ll_Qt_tributada

String ls_Nulo []
String ls_Texto_Email
String ls_Dados_Email
String ls_Email_Comprador
String ls_Matricula_Comprador
String ls_Matricula_Anterior = ""
String ls_Erro

If Not of_verifica_parametro_dias(ldh_data_inicio,ls_Erro) Then
	of_envia_email_log (ls_erro,'0','of_verifica_parametro_dias')
	Return False
End if

ldh_data_fim = RelativeDate(ldh_data_inicio, - 30) 

s_email str

dc_uo_ds_base lds_saldo_desconsiderado
lds_saldo_desconsiderado = Create dc_uo_ds_base
lds_saldo_desconsiderado.of_ChangeDataObject("ds_ge650_saldo_agendamento")
ll_Linhas = lds_saldo_desconsiderado.Retrieve('N', ldh_data_inicio, ldh_data_fim)

If ll_Linhas > 0 Then     
    For ll_Linha = 1 to ll_Linhas 
        ls_Matricula_Comprador = Trim(lds_saldo_desconsiderado.Object.nr_matricula_comprador[ll_Linha])

        // Se o comprador mudou e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ o primeiro registro, envia o e-mail antes de iniciar um novo
        If ls_Matricula_Comprador <> ls_Matricula_Anterior And ls_Matricula_Anterior <> "" Then
            // Envia o e-mail antes de processar o novo comprador
            If ls_Dados_Email <> "" Then
                ls_Texto_Email = "<HTML><BODY><H3>Relat$$HEX1$$f300$$ENDHEX$$rio de notas com atraso na entrega.</H3>"
                ls_Texto_Email += "<TABLE border='1' cellpadding='2' cellspacing='0' style='border-collapse: collapse;'>"
                ls_Texto_Email += ls_Dados_Email
                ls_Texto_Email += "</TABLE><BR>"
                ls_Texto_Email += "<P>Acesse a tela de agendamento de entrega e defina uma data da mesma para considerar novamente o saldo agendado no rateio.</P>"
                ls_Texto_Email += "</BODY></HTML>"

                ls_Email_Comprador = ls_Matricula_Anterior + "@clamed.com.br" 
				//	 ls_Email_Comprador = 	"giovani.santos@clamed.com.br"
                // Envio do e-mail
					 str.ps_to = ls_Nulo
                str.ps_to[UpperBound(str.ps_to)+1] = ls_Email_Comprador
                str.ps_Mensagem = ls_Texto_Email 
                str.pb_Assinatura = True
                gf_ge202_envia_email_padrao(344, str)
            End If

            ls_Dados_Email = ""
        End If 

        // Adiciona o cabe$$HEX1$$e700$$ENDHEX$$alho apenas no in$$HEX1$$ed00$$ENDHEX$$cio de cada novo comprador
        If ls_Matricula_Comprador <> ls_Matricula_Anterior Or ls_Dados_Email = "" Then
            ls_Dados_Email = "<tr bgcolor='#ffff66'>" + &
                            "<th align='center'>Data Emiss$$HEX1$$e300$$ENDHEX$$o</th>" + &
                            "<th align='center'>C$$HEX1$$f300$$ENDHEX$$d. Produto</th>" + &
                            "<th align='center'>Qt. Tributada</th>" + &
                            "<th align='center'>Fornecedor</th>" + &
                            "<th align='center'>Pedido Central</th>" + &
                            "<th align='center'>NF</th>" + &
                            "<th align='center'>Esp$$HEX1$$e900$$ENDHEX$$cie</th>" + &
                            "<th align='center'>S$$HEX1$$e900$$ENDHEX$$rie</th>" + &
                            "<th align='center'>Chave Acesso</th>" + &
                            "</tr>"
        End If

        // Adiciona os produtos do comprador atual
		  ll_Qt_tributada	= lds_saldo_desconsiderado.Object.qt_tributada[ll_Linha]
		  
        ls_Dados_Email += "<tr>" + &
                          "<td>" + String(lds_saldo_desconsiderado.Object.dh_emissao[ll_Linha], "dd/mm/yyyy") + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.cd_produto[ll_Linha]) + "</td>" + &
								   "<td align='right'>" + String(ll_Qt_tributada) + "</td>" + &
                          "<td>" + Left(Trim(lds_saldo_desconsiderado.Object.nm_razao_social[ll_Linha]), 40) + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.nr_pedido_central[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + string(lds_saldo_desconsiderado.Object.nr_nf[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + Trim(lds_saldo_desconsiderado.Object.de_especie[ll_Linha]) + "</td>" + &
                          "<td align='center'>" + Trim(lds_saldo_desconsiderado.Object.de_serie[ll_Linha]) + "</td>" + &
                          "<td>" + Trim(lds_saldo_desconsiderado.Object.de_chave_acesso[ll_Linha]) + "</td>" + &
                          "</tr>"
								  
        ls_Matricula_Anterior = ls_Matricula_Comprador
    Next

    // Enviar e-mail para o $$HEX1$$fa00$$ENDHEX$$ltimo comprador processado
    If ls_Matricula_Anterior <> "" And ls_Dados_Email <> "" Then
        ls_Texto_Email = "<HTML><BODY><H3>Relat$$HEX1$$f300$$ENDHEX$$rio de notas com atraso na entrega.</H3>"
        ls_Texto_Email += "<TABLE border='1' cellpadding='2' cellspacing='0' style='border-collapse: collapse;'>"
        ls_Texto_Email += ls_Dados_Email
        ls_Texto_Email += "</TABLE><BR>"
        ls_Texto_Email += "<P>Acesse a tela de agendamento de entrega e defina uma data da mesma para considerar novamente o saldo agendado no rateio.</P>"
        ls_Texto_Email += "</BODY></HTML>"

        ls_Email_Comprador = ls_Matricula_Anterior + "@clamed.com.br"
	//	  ls_Email_Comprador = 	"giovani.santos@clamed.com.br"
			
        // Envio do e-mail
		  str.ps_to = ls_Nulo
        str.ps_to[UpperBound(str.ps_to)+1] = ls_Email_Comprador
        str.ps_Mensagem = ls_Texto_Email 
        str.pb_Assinatura = True
        gf_ge202_envia_email_padrao(344, str)
    End If
End If 

Destroy (lds_saldo_desconsiderado)
Return True


end function

on uo_ge650_saldo_agendamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge650_saldo_agendamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

