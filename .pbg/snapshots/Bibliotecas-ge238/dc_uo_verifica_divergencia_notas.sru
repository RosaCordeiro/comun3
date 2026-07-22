HA$PBExportHeader$dc_uo_verifica_divergencia_notas.sru
forward
global type dc_uo_verifica_divergencia_notas from nonvisualobject
end type
end forward

global type dc_uo_verifica_divergencia_notas from nonvisualobject
end type
global dc_uo_verifica_divergencia_notas dc_uo_verifica_divergencia_notas

type variables
t_pedido_chave_nfe st_pedido_chave_nfe

s_email str

s_email str_Limpar

Boolean ib_Existe_Produto_Sem_pedido
Boolean ib_marca_verificado_divergencia_ped // se for true, o sistema ir$$HEX1$$e100$$ENDHEX$$ marcar o id_verificado_divergencia_ped para n$$HEX1$$e300$$ENDHEX$$o verificar novamente
Boolean ib_marreta_reposicao_sta = False	// as vezes a Santa Cruz envia XML sem a XVAN com a identica$$HEX2$$e700e300$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o para a inclus$$HEX1$$e300$$ENDHEX$$o do pedido central
Boolean ib_Grava_Agendamento = True
Boolean ib_Envia_Email_Fiscal = False
Boolean ib_Pedido_Ba
Boolean ib_Diverg_Ped_Trocado //Quando o pedido $$HEX1$$e900$$ENDHEX$$ gerado para um fornecedor e um outro fornecedor fatura a nota e informa um pedido que n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ dele
Boolean ib_Iniciado_Operacao_SAP
Boolean ib_valida_teste_integrado = False


Long ivl_Pedido
Long il_Nota
Long il_Filial
Long il_Pedido_Distrib
Long il_Pedido_Interface_SAP
Long il_Percentual_Limite_Divergencia    // Parametro Geral :  PC_LIMITE_DIVERGENCIA_AGENDAMENTO

String ivs_Chave_Acesso
String is_ftp_xml_endereco, is_ftp_xml_usuario, is_ftp_xml_senha
String is_Especie, is_Serie
String is_Recebimento_SAP

String ivs_Divergencias[]
String ivs_Divergencias_Agend[]
String ivs_Divergencias_Agend_Nao_Fornec[]

dc_uo_transacao iuo_SqlCa_log
end variables

forward prototypes
public function boolean of_busca_xml_ftp (string as_chave_acesso, date adt_emissao, long al_filial, string as_diretorio_xml, ref string as_mensagem_log)
public function boolean of_valida_pedido (t_infnfe at_infnfe, ref long al_pedido, ref string as_mensagem_log)
public function boolean of_valida_pedido_ativo (long al_pedido, ref string as_mensagem_log)
public function boolean of_valida_produtos_pedidos (t_infnfe at_infnfe, long al_pedido, ref string as_mensagem_log)
public function boolean of_envia_email_divergencias (long al_pedido, t_infnfe at_infnfe, string as_dir_xml, ref string as_mensagem_log)
private function boolean of_nota_ja_importada (string as_chave_acesso, ref string as_mensagem_log)
public function boolean of_verifica_limite_comprador (string as_matricula, decimal adc_valor, ref boolean ab_possui_limite, ref string as_mensagem_log)
public function boolean of_nosso_codigo_produto (string as_xprod, string as_ean, string as_eantrib, ref long al_produto, ref string as_mensagem_log)
public subroutine of_envia_email_pbm (string as_comprador, string as_email, long al_pedido, decimal adc_valor)
public function boolean of_pedido_pbm_ja_incluso (string as_chave_acesso, ref string as_messagem_log)
public function boolean of_verifica_produto_pbm (long al_produto, ref boolean ab_pbm, ref string as_mensagem_log)
public function boolean of_atualiza_cabecalho_nfe_indexacao (t_infnfe a_infnfe, string as_chave_nota, ref string as_mensagem_log)
public function boolean of_insere_item_nfe_indexacao (t_infnfe a_infnfe, string as_chave_acesso, ref string as_mensagem_log)
public function boolean of_grava_log (integer ai_arquivo, string as_mensagem)
public function boolean of_parametro_conexao_ftp ()
public function boolean of_insere_nf_agendamento_item_lote (string as_chave_acesso, t_prod at_prod, integer ai_item_nf, ref string as_mensagem)
public function boolean of_insere_nf_agendamento_titulo (t_infnfe at_infnfe, string as_chave_acesso, ref string as_mensagem_log)
public function boolean of_valida_parcelas_titulo (t_infnfe at_infnfe, boolean ab_stacruz, ref string as_mensagem)
public function boolean of_nf_agendamento_ent_divergencia ()
private function boolean of_grava_divergencia_agend (string as_divergencia, long al_tipo_divergencia, string as_de_produto, string as_cod_barras, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_xml)
public function boolean of_valida_produtos_pedido (string as_chave_acesso, long al_pedido, string as_cgc_forn, ref string as_mensagem)
private function boolean of_grava_divergencia (string as_divergencia, long al_tipo_divergencia, string as_de_produto, string as_cod_barras, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_nf)
public function boolean of_valida_cnpj_fornecedor (string as_cgc_fornecedor, long al_pedido, ref string as_mensagem_log, string as_chave_acesso)
public function boolean of_marca_verificado_divergencia_ped (string as_chave_acesso, integer ai_log, string as_index_destinadas)
public function boolean of_libera_nf_para_agendamento (string as_chave_acesso, ref string as_mensagem_log)
public function boolean of_inclui_pedido_pbm (t_infnfe at_infnfe, ref long al_pedido, ref string as_mensagem_log, string as_chave, ref boolean ab_erro)
public function boolean of_insere_cabecalho_pedido_pbm (string as_fornecedor, long al_condicao, long al_tipo_frete, decimal adc_vlped, string as_situacao, string as_chave_acesso, ref long al_pedido, ref string as_mensagem_log, t_infnfe at_infnfe, ref boolean ab_erro)
public function boolean of_insere_itens_pedido_pbm (long al_pedido, t_infnfe at_infnfe, ref string as_mensagem_log, string as_fornecedor, ref boolean ab_erro)
public function boolean of_verifica_pedido (string as_pedido, ref string as_pedido_sem_caractere)
private function boolean of_email_comprador (long al_pedido, string as_cnpj_fornecedor, ref string as_email, ref string as_mensagem_log, t_infnfe at_infnfe)
public function boolean of_valida_produto_pedido (t_infnfe at_infnfe, long al_pedido, ref string as_mensagem_log)
public function boolean of_valida_qtde_pedida_nova (t_infnfe at_infnfe, long al_indice, long al_pedido, long al_produto, ref string as_mensagem_log)
public function boolean of_valida_produto_pedido (string as_chave_acesso, long al_pedido, string as_cgc_forn, ref string as_mensagem)
public function boolean of_valida_qtde_pedida_nova (datastore ads, string as_chave_acesso, long al_indice, long al_pedido, long al_produto, ref string as_mensagem_log)
public function boolean of_verifica_email_comprador (t_infnfe at_infnfe, ref string as_email, long al_pedido, ref string as_mensagem_log)
public function boolean of_grava_historico_divergencia_agend (string as_chave_acesso, long al_tipo_divergencia, string as_de_divergencia, dc_uo_transacao a_sqlca, ref string as_mensagem_log)
public function boolean of_valida_cnpj_fornecedor_cadastrado (string as_cgc_fornecedor, ref string as_mensagem_log, string as_chave_acesso)
public function boolean of_atualiza_finalidade_nfe (string as_finnfe, string as_chave, ref string as_mensagem)
public function boolean of_valida_historico_embalagem_padrao (long al_pedido, long al_produto, string as_de_produto, string as_ean, string as_chave_acesso, long al_indice, ref string as_mensagem)
public function boolean of_valida_produto_xml (long al_nitemped, string as_cprod, string as_ean, string as_ean_trib, string as_cnpj_emit, string as_xprod, decimal adc_qtde, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_nf, ref long al_produto, boolean ab_grava_divergencia)
public function boolean of_envia_email_agendamento (string as_mensagem, string as_cnpj_forn, string as_de, ref string as_log, integer ai_log, boolean ab_envia_email_fornecedor)
public function boolean of_envia_email_divergencias_dll (long al_pedido, t_infnfe at_infnfe, string as_diretorio_xml, ref string as_mensagem_log, integer ai_log, boolean ab_envia_email_fornecedor)
public function boolean of_valida_data_emissao_pedido (long al_pedido, date adt_emissao_nf, ref string as_retorno)
public function boolean of_verifica_divergencias_agendamento (string as_chave_acesso, date adh_emissao_nf, ref string as_mensagem)
public function boolean of_valida_pedido (t_infnfe at_infnfe, string as_chave_acesso, date adt_emissao_nf, ref string as_mensagem_log, ref string as_mensagem_pbm)
public function boolean of_verifica_distribuidora_sc (string as_fornecedor, ref string as_mensagem_log)
public function boolean of_valida_pedido_distribuidora (long al_pedido_distribuidora, ref string as_mensagem_log)
protected function boolean of_insere_nf_agendamento_item (t_infnfe a_infnfe, string as_chave_acesso, ref string as_mensagem_log)
public function boolean of_valida_meta_compra (long al_pedido, ref string as_mensagem_log, string as_chave_acesso)
public function boolean of_valida_cnpj_pedido (string as_cgc_fornecedor, long al_pedido, ref string as_mensagem_log)
public function boolean of_valida_situacao_tributaria (long al_pedido_central, long al_produto, string as_de_produto, string as_ean, decimal adc_valor_icms, decimal adc_valor_st, string as_tributacao_icms, date adt_emissao, string as_uf_fornecedor, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_xml, string as_situacao_tributaria)
public function boolean of_msg_logistica_exclu_ba (integer ai_log)
public function boolean of_limpa_divergencia_sap (string as_chave_acesso, ref string as_log)
public function boolean of_executa_commit ()
private function boolean of_grava_divergencia (string as_divergencia, long al_tipo_divergencia, string as_de_produto, string as_cod_barras, ref string as_mensagem_log)
public function boolean of_valida_quantidade_fracionada (long al_pedido, long al_produto, decimal adc_qt_produto, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_nf, ref long al_caixa_padrao, ref string as_multiplicar_dividir)
public function boolean of_fecha_conexao_log ()
public function boolean of_abre_conexao_log (ref string ps_log)
private function boolean of_grava_log_receb_sap (string as_log, integer ai_item_xml, ref string as_log_ret)
public function boolean of_calcula_caixa_padrao (long al_pedido, long al_produto, decimal adc_quantidade, ref decimal adc_qtde_calculada, ref string as_mensagem_log, string as_chave_acesso, integer ai_sequencial_item_xml, ref long al_caixa_padrao, ref string as_multiplicar_dividir)
public function boolean of_verifica_excecao_regra (long al_produto, string as_fornecedor, ref long al_excecao, ref string as_log)
public function boolean of_localiza_parametros (ref string as_mensagem_log)
public function boolean of_nosso_codigo_produto_distrib (string as_fornecedor, long al_produto, ref string as_mensagem_log, ref long al_qt_embalagem_padrao_distrib)
public function boolean of_insere_nf_agendamento (t_infnfe a_infnfe, string as_chave_acesso, ref string as_mensagem_log, ref string as_mensagem_pbm, long al_filial, ref boolean ab_envio_email)
public function boolean of_valida_pedido (string as_chave_acesso, string as_cnpj, date adt_emissao_nf, ref string as_mensagem_log, long al_filial, ref boolean ab_envio_email)
public function boolean of_valida_preco_produto (long al_pedido, long al_produto, string as_de_produto, string as_ean, decimal adc_preco_unitario, decimal adc_pc_desconto, decimal adc_vl_icms_deson_unit, string as_chave_acesso, long al_embalagem_padrao, string as_dividir_multiplicar, long al_indice, date adt_recebido_sap, ref string as_mensagem)
public function boolean of_verifica_liberacao_agendamento (string as_chave_acesso, ref boolean ab_liberado, ref string as_log)
public function boolean of_verifica_divergencias (string as_chave_acesso, date adt_emissao, long al_pedido, long al_filial, string as_diretorio_xml, ref string as_mensagem_log, ref string as_mensagem_pbm, integer ai_log, string as_index_destinadas, boolean ab_iniciado_operacao_sap, string as_recebimento_sap, ref boolean ab_envio_email, ref string as_resolvido, ref datetime adt_resolvido)
public function boolean of_atualiza_pedido_distribuidora (string as_chave_acesso, ref string as_log)
public function boolean of_atualiza_pedido_central (ref string as_mensagem_log)
public function boolean of_atualiza_pedido_distribuidora_produto (long al_produto, long al_qt_faturada, string as_chave_acesso, ref string as_mensagem_log, long al_qt_embalagem_padrao_distrib)
end prototypes

public function boolean of_busca_xml_ftp (string as_chave_acesso, date adt_emissao, long al_filial, string as_diretorio_xml, ref string as_mensagem_log);String ls_Ano, ls_Mes, ls_Dia, ls_Cnpj, ls_Arquivo_Xml, ls_Mensagem, ls_Diretorio
Long ll_Ano, ll_Mes, ll_Dia
Boolean lb_Localizado

If Not of_parametro_conexao_ftp() Then Return False

dc_uo_Ftp lo_Ftp
lo_Ftp = Create dc_uo_Ftp

If Not lo_Ftp.of_Conecta_Ftp("", is_ftp_xml_endereco, is_ftp_xml_usuario, is_ftp_xml_senha,ref as_mensagem_log ) Then
	Destroy lo_Ftp	
	Return False
End If

ll_Ano = Year(adt_Emissao)
ll_Mes = Month(adt_Emissao)
ll_Dia = Day(adt_Emissao)

ls_Ano = "Ano_"+String(ll_Ano)
If ll_Mes < 10 Then ls_Mes = "Mes_0"+String(ll_Mes) Else ls_Mes = "Mes_"+String(ll_Mes)
If ll_Dia < 10 Then ls_Dia = "Dia_0"+String(ll_Dia) Else ls_Dia = "Dia_"+String(ll_Dia)
ls_Cnpj = Mid(as_Chave_Acesso, 7, 14)
ls_Arquivo_Xml = as_Chave_Acesso+"-nfe.xml"


ls_Diretorio = ls_Ano + "/" + ls_Mes + "/" + ls_Dia + "/" + ls_CNPJ

lb_Localizado = True

If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio, Ref ls_Mensagem) = -1 Then 
	as_mensagem_log = "XML n$$HEX1$$e300$$ENDHEX$$o localizado"
	lb_Localizado = False	
End If

If lb_Localizado Then
	If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo_Xml, as_Diretorio_Xml+ls_Arquivo_Xml, Ref ls_Mensagem) Then
		as_mensagem_log = "XML n$$HEX1$$e300$$ENDHEX$$o localizado"
		lb_Localizado = False
	End If
End If	

Destroy(lo_Ftp)

//// Desenvolvimento
////If Not lb_Localizado Then
////	Return False
////End If
//
//If Not lb_Localizado Then
//	lb_Localizado = True
//	If Not FileExists("C:\Windows\System32\Eventos_Sefaz.dll") Then
//	 	//MessageBox("Alerta", "N$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ instalado a DLL Eventos_Sefaz.dll.")	
//	  	lb_Localizado = False	
//	End If
//
//	If lb_Localizado Then
//		If Not FileExists("C:\NF\") Then
//			MessageBox("Alerta", "N$$HEX1$$e300$$ENDHEX$$o exixte o diret$$HEX1$$f300$$ENDHEX$$rio 'C:\NF\' utilizado para fazer o download do XML.")	
//			lb_Localizado = False	
//		End If
//	End If	
//	
////	If lb_Localizado Then
////		lb_Localizado = of_Download_Xml_Sefaz(as_Chave_Acesso, al_Filial, Ref ls_Mensagem)
////		as_mensagem_log = ls_Mensagem
////	End If	
//End If

Return lb_Localizado
end function

public function boolean of_valida_pedido (t_infnfe at_infnfe, ref long al_pedido, ref string as_mensagem_log);Long ll_Pedido, ll_Pedido_Produto, ll_Qtde, ll_Pos
String ls_Pedido, ls_Pedido_Inteiro_Prod, ls_Pedido_Inteiro_Cab, ls_Pedido_Sem_Caractere, ls_Ped_Dados_Adicionais

If Trim(at_infnfe.compra.xped) = "" And Trim(at_infnfe.det[1].prod.xped) = "" Then	
	as_Mensagem_Log  = "O fornecedor n$$HEX1$$e300$$ENDHEX$$o informou o n$$HEX1$$fa00$$ENDHEX$$mero do pedido na tag (xped) do XML"
	Return False
End If	

//xped do produto
If Trim(at_infnfe.det[1].prod.xped) <> "" Then
	ls_Pedido_Inteiro_Prod = at_infnfe.det[1].prod.xped
	
	ls_Pedido	=ls_Pedido_Inteiro_Prod
	
	//Trocado o '.' por '-' porque o isnumber considera o '.' como n$$HEX1$$fa00$$ENDHEX$$mero
	ls_Pedido = gf_Replace(ls_Pedido, ".", "-", 0)

	If Not IsNumber(ls_Pedido) Then
		If Not of_Verifica_Pedido(ls_Pedido, Ref ls_Pedido_Sem_Caractere) Then
			Return False
		End If
		
		ls_Pedido = ls_Pedido_Sem_Caractere
	End If
	
	ll_Pedido_Produto 	= Long(ls_Pedido)
	al_Pedido			= ll_Pedido_Produto
		
	select count(*)
	Into :ll_Qtde
	from pedido_central
	where nr_pedido = :ll_Pedido_Produto
	and dh_pedido > dateadd(month,-6,getdate())
	and cd_filial = 534
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case 0
			If ll_Qtde > 0 Then
				Return True
			Else
				
				//Procura por "_", "_", "/". Se houver algum caracter desses, o sistema utiliza os n$$HEX1$$fa00$$ENDHEX$$meros a esquerda
				//Ex: xped = 12345_xxxxx o sistema ir$$HEX1$$e100$$ENDHEX$$ utilizar 12345
				ll_Pos = PosA(ls_Pedido_Inteiro_Prod, "_")
				
				If ll_Pos = 0 Then
					ll_Pos = PosA(ls_Pedido_Inteiro_Prod, "-")
				End If
				
				If ll_Pos = 0 Then
					ll_Pos = PosA(ls_Pedido_Inteiro_Prod, "/")
				End If
				
				If ll_Pos > 0 Then
				
					If IsNumber(MidA( ls_Pedido_Inteiro_Prod, 1, ll_Pos - 1)) Then
						ll_Pedido_Produto = Long(MidA( ls_Pedido_Inteiro_Prod, 1, ll_Pos - 1))
						
						select count(*)
							Into :ll_Qtde
						from pedido_central
						where nr_pedido = :ll_Pedido_Produto
							and dh_pedido > dateadd(month,-6,getdate())
							and cd_filial = 534
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + ls_Pedido_Inteiro_Prod + "' na tabela 'pedido_central'. " + SqlCa.SqlErrText
							Return False
						End If
						
						If ll_Qtde > 0 Then
							al_Pedido = ll_Pedido_Produto
							Return True
						End If
					End If
				End If
					
				If Not of_Valida_Pedido_Distribuidora(ll_Pedido_Produto, Ref as_Mensagem_Log) Then Return False
				
				If ib_Pedido_Ba Then Return False //Se encontrou o pedido exclusivo da Bahia retorna falso para depois entrar na rotina onde ir$$HEX1$$e100$$ENDHEX$$ grava o pedido_central
				
//				If at_infnfe.emit.Cnpj = "60409075011782" Then
//					as_Mensagem_Log = "O pedido informado nos dados adicionais (tag infAdic) do XML '" + ls_Pedido_Inteiro_Prod + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado em nossa base de dados."
//					SetNull(al_pedido)
//					Return False
//				End If				
			End If
						
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + ls_Pedido_Inteiro_Prod + "' na tabela 'pedido_central'. " + SqlCa.SqlErrText
			Return False
	End Choose
End If

// Para for$$HEX1$$e700$$ENDHEX$$ar a entrada na pr$$HEX1$$f300$$ENDHEX$$xima valida$$HEX2$$e700e300$$ENDHEX$$o
If Trim(at_infnfe.compra.xped) = "" Then
	at_infnfe.compra.xped = ls_Pedido	
End If

//xped da nota
If Trim(at_infnfe.compra.xped) <> "" Then
	ls_Pedido_Inteiro_Cab = at_infnfe.compra.xped
	
	ls_Pedido	=ls_Pedido_Inteiro_Cab
	
	//Trocado o '.' por '-' porque o isnumber considera o '.' como n$$HEX1$$fa00$$ENDHEX$$mero
	ls_Pedido	= gf_Replace(ls_Pedido, ".", "-", 0)
	
	If Not IsNumber(ls_Pedido) Then
		If Not of_Verifica_Pedido(ls_Pedido, Ref ls_Pedido_Sem_Caractere) Then
			Return False
		End If
		
		ls_Pedido = ls_Pedido_Sem_Caractere
	End If
	
	ll_Pedido 	= Long(ls_Pedido)
	al_Pedido	= ll_Pedido
	
	select count(*)
	Into :ll_Qtde
	from pedido_central
	where nr_pedido = :ll_Pedido
	and dh_pedido > dateadd(month,-6,getdate())
	and cd_filial = 534
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case 0
			
			If ll_Qtde = 0 Then
				//Procura por "_", "_", "/". Se houver algum caracter desses, o sistema utiliza os n$$HEX1$$fa00$$ENDHEX$$meros a esquerda
				//Ex: xped = 12345_xxxxx o sistema ir$$HEX1$$e100$$ENDHEX$$ utilizar 12345
				
				ll_Pos = PosA(ls_Pedido_Inteiro_Cab, "_")
				
				If ll_Pos = 0 Then
					ll_Pos = PosA(ls_Pedido_Inteiro_Cab, "-")
				End If
				
				If ll_Pos = 0 Then
					ll_Pos = PosA(ls_Pedido_Inteiro_Cab, "/")
				End If
				
				If ll_Pos > 0 Then
					
					If IsNumber(MidA( ls_Pedido_Inteiro_Cab, 1, ll_Pos - 1)) Then
				
						ll_Pedido = Long(MidA( ls_Pedido_Inteiro_Cab, 1, ll_Pos - 1))
						
						select count(*)
							Into :ll_Qtde
						from pedido_central
						where nr_pedido = :ll_Pedido
							and dh_pedido > dateadd(month,-6,getdate())
							and cd_filial = 534
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + ls_Pedido_Inteiro_Prod + "' na tabela 'pedido_central'. " + SqlCa.SqlErrText
							Return False
						End If
						
						If ll_Qtde > 0 Then
							al_Pedido = ll_Pedido
							Return True
						End If
					End If
				End If
					
				If Not of_Valida_Pedido_Distribuidora(ll_Pedido, Ref as_Mensagem_Log) Then Return False
				
				If ib_Pedido_Ba Then Return False //Se encontrou o pedido exclusivo da Bahia retorna falso para depois entrar na rotina onde ir$$HEX1$$e100$$ENDHEX$$ grava o pedido_central
				
				//Tratamento da mensagem de diverg$$HEX1$$ea00$$ENDHEX$$ncia que ser$$HEX1$$e100$$ENDHEX$$ informada no email
				If Not IsNull(ls_Pedido_Inteiro_Prod) And ls_Pedido_Inteiro_Prod <> "" Then
					as_Mensagem_Log = "O pedido informado na tag (xPed) do XML '" + ls_Pedido_Inteiro_Prod + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado em nossa base de dados."
					SetNull(al_pedido)
					Return False
				End If
				
				If Not IsNull(ls_Pedido_Inteiro_Cab) And ls_Pedido_Inteiro_Cab <> "" Then
					as_Mensagem_Log = "O pedido informado na tag (xPed) do XML '" + ls_Pedido_Inteiro_Cab + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado em nossa base de dados."
					SetNull(al_pedido)
					Return False
				End If
			Else
				Return True
			End If
						
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + ls_Pedido_Inteiro_Cab + "' na tabela 'pedido_central'. " + SqlCa.SqlErrText
			Return False
	End Choose
Else
	as_Mensagem_Log = "O pedido informado na tag (xPed) do XML '" + ls_Pedido_Inteiro_Prod + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado em nossa base de dados."
	SetNull(al_pedido)
	Return False
End If

Return False
end function

public function boolean of_valida_pedido_ativo (long al_pedido, ref string as_mensagem_log);String ls_Situacao

select id_situacao
Into :ls_Situacao
from pedido_central
where nr_pedido = :al_pedido
and id_situacao in ('R', 'X')
and cd_filial = 534
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		If ls_Situacao = "R" Then
			as_Mensagem_Log = "A situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '"+String(al_pedido)+"' est$$HEX1$$e100$$ENDHEX$$ como 'Rascunho'."
			Return False	
		ElseIf ls_Situacao = "X" Then
			as_Mensagem_Log = "A situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '"+String(al_pedido)+"' est$$HEX1$$e100$$ENDHEX$$ como 'Cancelado'."
			Return False	
		End If
	Case -1
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido '"+String(al_pedido)+"' na tabela 'pedido_central'. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_valida_produtos_pedidos (t_infnfe at_infnfe, long al_pedido, ref string as_mensagem_log);String	ls_Cgc_Pedido,&
		ls_Cgc_Xml,&
		ls_Ean,&
		ls_Tributacao_Icms,&
		ls_Cgc_Fornecedor,&
		ls_Produto_Distribuidora,&
		ls_Ean_Trib,&
		ls_Xprod
		
Long	ll_Qt_Itens,&
		i,&
		ll_Produto,&
		ll_Qtde,&
		ll_Nf,&
		ll_Cod_Produto_Pedido,&
		ll_Achou
		
Decimal	ldc_Icms,&
			ldc_Icms_St,&
			ldc_Qt_produto

ll_Nf = at_Infnfe.ide.nnf
ll_Qt_Itens = UpperBound(at_InfNFe.det[])
	
For i = 1 to  ll_Qt_Itens
	
	SetNull(ll_Produto)
	
	ll_Cod_Produto_Pedido	= at_infnfe.det[i].prod.nitemped
	ls_Produto_Distribuidora 	= at_Infnfe.det[i].prod.cprod
	ls_Ean						= trim(at_Infnfe.det[i].prod.cean)
	ls_Ean_Trib					= trim(at_Infnfe.det[i].prod.ceantrib)
	ls_Cgc_Fornecedor		= at_Infnfe.emit.cnpj
	ls_Xprod						= at_Infnfe.det[i].prod.xprod
	ldc_Qt_produto				= at_Infnfe.det[i].prod.qcom
	
	If Not of_Valida_Produto_Xml(ll_Cod_Produto_Pedido, ls_Produto_Distribuidora, ls_Ean, ls_Ean_Trib, ls_Cgc_Fornecedor, ls_Xprod, ldc_Qt_produto, Ref as_Mensagem_Log, '', 0, ref ll_Produto, True) Then
		Return False
	End If
	
	at_Infnfe.det[i].prod.cd_produto_clamed = ll_Produto
	
Next

If Not This.of_valida_produto_pedido(at_infnfe, al_pedido, as_mensagem_log) Then Return False

Return True
end function

public function boolean of_envia_email_divergencias (long al_pedido, t_infnfe at_infnfe, string as_dir_xml, ref string as_mensagem_log);uo_smtp lo_smtp
Long ll_Nr_Nf, ll_Linha, ll_Linhas, ll_Qtd_Email
String ls_Chave_Nota, ls_Especie, ls_Serie, ls_Divergencias, ls_Texto_Email, ls_Cnpj_Fornecedor, ls_Email, ls_Nm_Fornecedor
String ls_Pedido = ""
String ls_destinatarios[], ls_Anexo[], ls_Email_Copia[]
Decimal ldc_Valor_Nf
String ls_Nat_Operacao

ls_Cnpj_Fornecedor = at_Infnfe.emit.cnpj

//If Not of_email_comprador(al_Pedido, ls_Cnpj_Fornecedor, Ref ls_Email, Ref as_mensagem_log, at_infnfe) Then
//	Return False
//End If

If Not of_Verifica_Email_Comprador(at_infnfe, ls_Email, al_Pedido, Ref as_mensagem_log) Then
	Return False
End If

//ls_Email_Copia[] = {"tiago.pacheco@clamed.com.br", "anderson.lima@clamed.com.br"}
ls_destinatarios[1] = "heder@clamed.com.br"


Try
	lo_smtp = Create uo_smtp
	lo_smtp.ib_grava_log_db = False
	
	ls_Chave_Nota 		= ivs_Chave_Acesso
	ll_Nr_Nf 				= at_Infnfe.ide.nnf
	ls_Especie			= "NFE"
	ls_Serie				= at_Infnfe.ide.serie
	ls_Nm_Fornecedor	= at_Infnfe.emit.xnome
	ldc_Valor_Nf		= at_Infnfe.total.icmstot.vnf
	ls_Nat_Operacao	= at_Infnfe.ide.natop
	
	ll_Linhas = UpperBound(ivs_Divergencias[])
	
	For ll_Linha = 1 to ll_Linhas
		ls_Divergencias = ls_Divergencias + "~r"+ ivs_Divergencias[ll_Linha]+"~r"
	Next
	
	If Not IsNull(al_Pedido) Then
		ls_Pedido = 	String(al_Pedido)
	End If
	
	ls_Texto_Email =	"FORNECEDOR: "+ls_Nm_Fornecedor+"~r"+&
							"NOTA: "+String(ll_Nr_Nf)+"~r"+&
							"VALOR: "+String(ldc_Valor_Nf, "###,###.00")+"~r"+&
							"NAT. OPERA$$HEX2$$c700c300$$ENDHEX$$O: "+ls_Nat_Operacao+"~r"+&
							"PEDIDO: "+ls_Pedido+"~r"+&
							"CHAVE DE ACESSO: "+ls_Chave_Nota+"~r"+&
							ls_Divergencias
	
	ls_Anexo[1] = as_Dir_Xml
	
	lo_smtp.of_envia_email_anexo( "RO", &
											  "sistemas@clamed.com.br", &
											  "Diverg$$HEX1$$ea00$$ENDHEX$$ncias Notas", &
												ls_Texto_Email, &
											  ls_destinatarios,&
											  ls_Email_Copia,&
											  ls_Anexo)
Finally
	Destroy(lo_smtp)
End Try

Return True
end function

private function boolean of_nota_ja_importada (string as_chave_acesso, ref string as_mensagem_log);Long ll_Nf 

Select Top 1 nr_nf
		into :ll_Nf
from 	(select  nr_nf 
		from nf_compra 
		where de_chave_acesso = :as_Chave_Acesso
		union
		select  nr_nf 
		from nf_compra_pendente 
		where de_chave_acesso = :as_Chave_Acesso
) as tudo	
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		as_Mensagem_Log = "A nota j$$HEX1$$e100$$ENDHEX$$ foi importada."
		Return True

	Case -1
		as_Mensagem_Log = "Verifica se a nota j$$HEX1$$e100$$ENDHEX$$ foi importada: " + SqlCa.SqlErrText
		Return True
End Choose

Return False
end function

public function boolean of_verifica_limite_comprador (string as_matricula, decimal adc_valor, ref boolean ab_possui_limite, ref string as_mensagem_log);Decimal ldc_Limite

Select vl_maximo_liberado
	Into :ldc_Limite
From nivel_liberacao_pedido_usuario
where nr_matricula = :as_matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If adc_valor <= ldc_Limite Then ab_possui_limite = True
	Case 100
		//as_mensagem_log = "Limite do comprador " + as_Matricula + " n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		//Return False
	Case -1
		as_mensagem_log = "Erro na consulta do vl_maximo_liberado para matric: " + as_matricula + " . " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_nosso_codigo_produto (string as_xprod, string as_ean, string as_eantrib, ref long al_produto, ref string as_mensagem_log);Long ll_Produto

String ls_Ean

SetNull(ll_Produto)

If ( as_EAN = "" ) And ( as_Eantrib = "" ) Then
	as_mensagem_log = "O produto '"+as_xprod+"' est$$HEX1$$e100$$ENDHEX$$ sem o c$$HEX1$$f300$$ENDHEX$$digo de barras no arquivo XML."
	Return False
Else
	//Adicionada a coluna id_principal para n$$HEX1$$e300$$ENDHEX$$o ter mais de um registro por linha
	
	ls_Ean = "%"+gf_Tira_Zero_Esquerda( as_EAN )
	
	select cd_produto
	Into :ll_Produto
	from codigo_barras_produto 
		where de_codigo_barras like :ls_Ean
	and id_principal = 'S'
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case 100			
			
			select cd_produto 
				Into :ll_Produto
			from codigo_barras_produto 
			where de_codigo_barras like :ls_Ean
				and id_principal = 'N'
			Using SqlCa;
					
			Choose Case SqlCa.SqlCode
				Case 100
					ls_Ean = "%"+gf_Tira_Zero_Esquerda( as_EANTrib )
	
					select cd_produto 
						Into :ll_Produto
					from codigo_barras_produto 
					where de_codigo_barras like :ls_Ean
					Using SqlCa;
					
					Choose Case SqlCa.SqlCode
						Case 100
							as_Mensagem_Log = "Nenhum produto foi localizado em nossa base de dados com o EAN '" + as_ean + "' informado no XML."
							Return False
							
						Case -1
							as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto atrav$$HEX1$$e900$$ENDHEX$$s do EAN '" + ls_EAN + "'." + SqlCa.SqlErrText
							Return False
					End Choose
						
				Case -1
					as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto atrav$$HEX1$$e900$$ENDHEX$$s do EAN '" + ls_EAN + "'." + SqlCa.SqlErrText
					Return False
			End Choose
			
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto atrav$$HEX1$$e900$$ENDHEX$$s do EAN '" + ls_EAN + "'." + SqlCa.SqlErrText
			Return False
	End Choose
End If

al_produto = ll_Produto

Return True
end function

public subroutine of_envia_email_pbm (string as_comprador, string as_email, long al_pedido, decimal adc_valor);String ls_To[]
String ls_Cc[]
String ls_Texto

uo_smtp lo_smtp
lo_smtp = Create uo_smtp

lo_smtp.ib_grava_log_db = False

ls_To[1] = as_Email


ls_Texto = "O pedido de PBM " + String( al_Pedido) + " foi inclu$$HEX1$$ed00$$ENDHEX$$do de forma autom$$HEX1$$e100$$ENDHEX$$tica pelo sistema.<br><br>" +& 
				"Como o valor do pedido passou da sua al$$HEX1$$e700$$ENDHEX$$ada o mesmo ficou como RASCUNHO e ficar$$HEX1$$e100$$ENDHEX$$ aguardando a libera$$HEX2$$e700e300$$ENDHEX$$o de um respons$$HEX1$$e100$$ENDHEX$$vel.<br><br>" + &
				"Valor: " + String( adc_Valor )

//Validacao Heder
If as_Comprador = "995559" Then
	lo_smtp.of_envia_email( "GN", &
							  "sistemas@clamed.com.br", &
							  "Importa$$HEX2$$e700e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tica de Pedido PBM", &
							  ls_Texto, &
							  ls_To)      
Else
	ls_Cc[1] = "heder@clamed.com.br"
	lo_smtp.of_envia_email( "GN", &
							  "sistemas@clamed.com.br", &
							  "Importa$$HEX2$$e700e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tica de Pedido PBM", &
							  ls_Texto, &
							  ls_To,&
							  ls_Cc)      
	
End If  	

Destroy lo_smtp
end subroutine

public function boolean of_pedido_pbm_ja_incluso (string as_chave_acesso, ref string as_messagem_log);Long ll_Pedido

Select nr_pedido
	Into :ll_Pedido
From pedido_central
	Where de_chave_acesso_nfe = :as_chave_acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		Return False
	Case 0
		as_Messagem_Log = "Esta NF ja est$$HEX1$$e100$$ENDHEX$$ vinculada ao pedido " + String( ll_Pedido ) + "."
	Case -1
		as_Messagem_Log = "Erro ao verificar o pedido ja incluso na tb_pedido_central. " + SqlCa.SqlErrText
End Choose

Return True
end function

public function boolean of_verifica_produto_pbm (long al_produto, ref boolean ab_pbm, ref string as_mensagem_log);Boolean lb_Sucesso = True

Long ll_Produto
Long ll_Linhas

String ls_EAN
String ls_Mensagem_Log

dc_uo_ds_base lds_PBM
lds_PBM = Create dc_uo_ds_base
		
If Not lds_PBM.of_ChangeDataObject("ds_ge238_produto_pbm") Then
	as_Mensagem_Log = "Erro no of_ChangeDataObject('ds_ge238_produto_pbm')."
	Destroy lds_PBM
	Return False
End If

ll_Linhas = lds_PBM.Retrieve( al_Produto )

Choose Case ll_Linhas
		
	Case -1
		as_Mensagem_Log = "Erro no Retrieve ds (ds_ge238_produto_pbm) - Produto: " + String( al_Produto )
		lb_Sucesso = False
		
	Case 0
		as_Mensagem_Log ="O pedido nao pode ser incluido. O produto " + String( al_Produto ) + " nao consta na tabela pbm_produto."
		ab_pbm = False
		
		//lb_Sucesso = False
		
	Case Is > 0
		ab_pbm = True
		
End Choose
		
Destroy lds_PBM

Return lb_Sucesso
end function

public function boolean of_atualiza_cabecalho_nfe_indexacao (t_infnfe a_infnfe, string as_chave_nota, ref string as_mensagem_log);Date ldt_Emissao
Date ldt_Entrada
Date ldt_Situacao

Double	ld_Vl_Bc_Icms, ld_Vl_ICMS, ld_Vl_Bc_Icms_St, ld_Vl_Icms_St, ld_Vl_Total_Produtos, ld_Vl_Ipi, ld_Vl_Frete,&
			ld_Vl_Seguro, ld_Vl_Outras_Despesas, ld_Vl_Desconto, ld_Vl_Total_Nf
					
Long ll_Nr_Nf

String ls_Achou	
String ls_Emissao
String ls_Cnpj
String ls_Serie
String ls_Cnpj_Destino
String ls_Erro_Sql

ld_Vl_Bc_Icms 						= a_infnfe.total.ICMSTot.vBC
ld_Vl_ICMS 							= a_infnfe.total.ICMSTot.vICMS
ld_Vl_Bc_Icms_St 					= a_infnfe.total.ICMSTot.vBCST
ld_Vl_Icms_St 						= a_infnfe.total.ICMSTot.vST
ld_Vl_Total_Produtos 				= Round((a_infnfe.total.ICMSTot.vProd - a_infnfe.total.ICMSTot.vDesc), 2)

ld_Vl_Ipi 								= a_infnfe.total.ICMSTot.vIPI
ld_Vl_Frete 							= a_infnfe.total.ICMSTot.vFrete
ld_Vl_Seguro 						= a_infnfe.total.ICMSTot.vSeg
ld_Vl_Outras_Despesas 			= a_infnfe.total.ICMSTot.vOutro
ld_Vl_Desconto 					= 0
ld_Vl_Total_Nf 						= a_infnfe.total.ICMSTot.vNF

Select id_nf
Into :ls_Achou
From nfe_indexacao
Where id_nf = :as_chave_nota
Using SqlCa;

Choose Case SqlCa.SqlCode
			
	Case 0
		UPDATE nfe_indexacao  
			SET	vl_bc_icms = :ld_Vl_Bc_Icms,   
					vl_icms = :ld_Vl_ICMS,   
					vl_bc_icms_st = :ld_Vl_Bc_Icms_St,   
					vl_icms_st = :ld_Vl_Icms_St,   
					vl_total_produtos = :ld_Vl_Total_Produtos,   
					vl_ipi = :ld_Vl_Ipi,   
					vl_frete = :ld_Vl_Frete,   
					vl_seguro = :ld_Vl_Seguro,   
					vl_outras_despesas = :ld_Vl_Outras_Despesas,   
					vl_desconto = :ld_Vl_Desconto,   
					vl_total_nf = :ld_Vl_Total_Nf   
		Where id_nf = :as_chave_nota
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode 
			Case -1		
				ls_Erro_Sql = SqlCa.sqlerrtext
				SqlCa.of_RollBack();
				as_Mensagem_Log = "Erro ao atualizar o cabe$$HEX1$$e700$$ENDHEX$$alho da nota (nfe_indexacao): "+ ls_Erro_Sql
				Return False
			Case 0		
				Return True
		End Choose

		as_Mensagem_Log = "Erro desconhecido ao inserir o cabe$$HEX1$$e700$$ENDHEX$$alho da nota"
		Return False	
		
	Case 100
			
		ls_Emissao		= String(a_infnfe.ide.demi, "yyyymmdd")
		ls_Cnpj 			= a_infnfe.emit.cnpj
		ls_Serie			= a_infnfe.ide.serie
		ls_Cnpj_Destino= a_infnfe.dest.cnpj
		ll_Nr_Nf			= a_infnfe.ide.nnf
		ldt_Emissao		= a_infnfe.ide.demi
		ldt_Situacao		= Date(gf_GetServerDate())
				
		Insert Into nfe_indexacao(id_nf,
										cgc_origem,
										nr_nf,
										de_especie,
										de_serie,
										cgc_destino,
										dh_emissao,
										id_situacao,
										dh_situacao,
										dh_entrada,
										vl_bc_icms,
										vl_icms,
										vl_bc_icms_st,
										vl_icms_st,
										vl_total_produtos,
										vl_ipi,	
										vl_frete,
										vl_seguro,
										vl_outras_despesas,
										vl_desconto,
										vl_total_nf,
										id_verificado_divergencia_ped)
										
					Values   (:as_chave_nota,
								:ls_Cnpj,
								:ll_Nr_Nf,
								'NFE',
								:ls_Serie,
								:ls_Cnpj_Destino,
								:ldt_Emissao,
								'L',
								:ldt_Situacao,
								getdate(),
								:ld_Vl_Bc_Icms,   
								:ld_Vl_ICMS,   
								:ld_Vl_Bc_Icms_St,   
								:ld_Vl_Icms_St,   
								:ld_Vl_Total_Produtos,   
								:ld_Vl_Ipi,   
								:ld_Vl_Frete,   
								:ld_Vl_Seguro,   
								:ld_Vl_Outras_Despesas,   
								:ld_Vl_Desconto,   
								:ld_Vl_Total_Nf,
								'N')
					Using SqlCa;
							
			If SqlCa.SqlCode = -1 Then
				ls_Erro_Sql = SqlCa.sqlerrtext
				SqlCa.of_RollBack();
				as_Mensagem_Log = "Erro ao inserir NF na tabela NFE_INDEXACAO" + ls_Erro_Sql
				Return False
			End If
				
			If SqlCa.SqlCode = 0 Then
				Return True
			End If
			
	Case -1
		ls_Erro_Sql = SqlCa.sqlerrtext
		as_Mensagem_Log = "Erro ao consultar tabela NFE_INDEXACAO" + ls_Erro_Sql
		Return False
			
End Choose
end function

public function boolean of_insere_item_nfe_indexacao (t_infnfe a_infnfe, string as_chave_acesso, ref string as_mensagem_log);Long ll_Itens, i, ll_Qtde_Fat, ll_Nr_Classificacao_Fiscal, ll_NatOp, ll_Produto_Ped

String ls_Cd_Produto_Xml, ls_Ean_Xml, ls_Cd_Cst_Origem, ls_Cd_Cst_Tributacao, ls_Nome_PRD, ls_Chave, ls_Achou, ls_Ean_Trib

Decimal ldc_Vl_Preco_Unitario, ldc_Pc_Desconto, ldc_Pc_Icms, ldc_Vipi, ldc_Vbc, ldc_Pc_Ipi, ldc_bc_icms, ldc_Pc_Reducao_Base_Icms

Decimal ldc_Vl_Bc_Icms_St_Total, ldc_Vl_Icms_St_Total, ldc_Vl_Outras_Despesas, ldc_Pc_Icms_St, ldc_Frete, ldc_Seguro, ldc_ICMS, ldc_Red_BC_ST


ll_Itens = UpperBound(a_InfNFe.det[])
	
For i = 1 to  ll_Itens
		
	ll_Qtde_Fat = a_InfNFe.det[i].prod.qCom 
	
	ls_Cd_Produto_Xml 	=	a_InfNFe.det[i].prod.cProd
	ls_Ean_Xml				= 	trim(a_InfNFe.det[i].prod.cEan)
	ls_Ean_Trib				= 	Trim(a_InfNFe.det[i].prod.ceantrib)
	
	ls_Nome_PRD			= a_InfNFe.det[i].prod.xprod
		
	ls_Chave = "(Filial: 534 - Chave: " +  as_chave_acesso + " - EAN: " + ls_Ean_Xml + ")"		
		 
	ldc_Vl_Preco_Unitario = round(a_InfNFe.det[i].prod.vUnCom, 2)
	
	//Tratamento para n$$HEX1$$e300$$ENDHEX$$o ocorrer divis$$HEX1$$e300$$ENDHEX$$o por zero
	If (ll_Qtde_Fat * a_InfNFe.det[i].prod.vUnCom) > 0 Then
		ldc_Pc_Desconto = round((a_InfNFe.det[i].prod.vDesc / (ll_Qtde_Fat * a_InfNFe.det[i].prod.vUnCom))* 100, 2)
	End If
	
	If ldc_Pc_Desconto < 0.00 Or ldc_Pc_Desconto > 100.00 Then
		as_Mensagem_Log = "PC desconto invalido. EAN: " + ls_Ean_Xml
		Return False
	End If
	
	If a_InfNFe.det[i].imposto.IPI.TipoIpi = "IPITrib" Then
		ldc_Vipi 		= round(a_InfNFe.det[i].imposto.IPI.IPITrib.vIPI, 2)
		ldc_Vbc 		= round(a_InfNFe.det[i].imposto.IPI.IPITrib.vBC, 2)
		ldc_Pc_Ipi 	= round(a_InfNFe.det[i].imposto.ipi.IPITrib.pIPI, 2)
	Else
		ldc_Vipi = 0
		ldc_Vbc = 0
		ldc_Pc_Ipi = 0
	End If
			
	ldc_bc_icms 						= round(a_InfNFe.det[i].imposto.ICMS.vBC, 2)
	ldc_Pc_Reducao_Base_Icms		= round(a_InfNFe.det[i].imposto.ICMS.pRedBC	,2)
	ldc_Pc_Icms 						= round(a_InfNFe.det[i].imposto.ICMS.pICMS,2)
	ldc_ICMS								= round(a_InfNFe.det[i].imposto.ICMS.vicms,2)
	
	ldc_Vl_Bc_Icms_St_Total 		= round(a_InfNFe.det[i].imposto.ICMS.vBCST,2)			
	ldc_Pc_Icms_St 					= round(a_InfNFe.det[i].imposto.ICMS.pICMSST,2)
	ldc_Vl_Icms_St_Total 			= round(a_InfNFe.det[i].imposto.ICMS.vICMSST,2)
	ldc_Red_BC_ST					= round(a_InfNFe.det[i].imposto.ICMS.predbcst,2)	
						
	ldc_Vl_Outras_Despesas 		= round(a_InfNFe.det[i].prod.vOutro, 2) // Valor total
	
	
	ls_Cd_Cst_Origem 				= String(a_InfNFe.det[i].imposto.ICMS.orig)
	ls_Cd_Cst_Tributacao 			= a_InfNFe.det[i].imposto.ICMS.CST
			
	ll_Nr_Classificacao_Fiscal 		= a_InfNFe.det[i].prod.NCM
	ll_NatOp								= Long(a_InfNFe.det[i].prod.cfop)
	
	ldc_Frete 							= round(a_InfNFe.det[i].prod.vfrete,2)
	ldc_Seguro 							= round(a_InfNFe.det[i].prod.vseg,2)
	
	ll_Produto_Ped						= a_InfNFe.det[i].prod.nitemped
	
	Select id_nf
	Into :ls_Achou
	From nfe_indexacao_item
	Where id_nf 	= :as_chave_acesso
		and nr_item = :i
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Return True // S$$HEX1$$f300$$ENDHEX$$ verifica uma vez.
		Case 100
		
			INSERT INTO nfe_indexacao_item  ( 		id_nf,   
																nr_item,   
																cd_produto,   
																de_codigo_barras,   
																de_produto,   
																nr_classificacao_fiscal,   
																cd_natureza_operacao,   
																qt_faturada,   
																vl_preco_unitario,   
																pc_desconto,   
																vl_frete,   
																vl_seguro,   
																nr_item_pedido,   
																cd_cst_origem,   
																cd_cst_tributacao,   
																vl_bc_icms,   
																pc_reducao_bc_icms,
																vl_icms,   
																vl_bc_icms_st,   
																pc_reducao_bc_icms_st,
																pc_icms_st,
																vl_icms_st,   
																vl_bc_ipi,   
																vl_ipi,   
																vl_outras_despesas,
																de_codigo_barras_trib)  
			VALUES ( 	:as_chave_acesso,			//id_nf,   
							:i,									//nr_item,   
							:ls_Cd_Produto_Xml,			//cd_produto,   
							:ls_Ean_Xml,					//de_codigo_barras,   
							:ls_Nome_PRD,					//de_produto,   
							:ll_Nr_Classificacao_Fiscal,	//nr_classificacao_fiscal,   
							:ll_NatOp,						//cd_natureza_operacao,   
							:ll_Qtde_Fat,					//qt_faturada,   
							:ldc_Vl_Preco_Unitario, 		//vl_preco_unitario,   
							:ldc_Pc_Desconto,				//pc_desconto,   
							:ldc_Frete,						//vl_frete,   
							:ldc_Seguro,					//vl_seguro,   
							:ll_Produto_Ped,				//nr_item_pedido,   
							:ls_Cd_Cst_Origem,			//cd_cst_origem,   
							:ls_Cd_Cst_Tributacao,		//cd_cst_tributacao,   
							:ldc_bc_icms,						//vl_bc_icms,   
							:ldc_Pc_Reducao_Base_Icms,	//
							:ldc_ICMS,							//vl_icms,   
							:ldc_Vl_Bc_Icms_St_Total,		//vl_bc_icms_st,   
							:ldc_Red_BC_ST,		
							:ldc_Pc_Icms_St,
							:ldc_Vl_Icms_St_Total,			//vl_icms_st,   
							:ldc_Vbc,								//vl_bc_ipi,   
							:ldc_Vipi,								//vl_ipi,   
							:ldc_Vl_Outras_Despesas, :ls_Ean_Trib	) 	//vl_outras_despesas)  ;
			Using SqlCa;		
			
			If SqlCa.SqlCode  = -1 Then
				as_Mensagem_Log = "Erro no insert "+ ls_Chave +": "+ SqlCa.SQLErrText
				SqlCa.of_RollBack();
				Return False
			End If
		
	Case -1 
		as_Mensagem_Log = "Erro ao localizar a nfe_indexacao_item "+ ls_Chave +": "+ SqlCa.SQLErrText
		SqlCa.of_RollBack();
		Return False	
		
	End Choose

Next


Return True
end function

public function boolean of_grava_log (integer ai_arquivo, string as_mensagem);String lvs_Mensagem

Integer lvi_Write
	
lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
               " - " + as_Mensagem

lvi_Write = FileWrite(ai_Arquivo, lvs_Mensagem)

If lvi_Write = LenA(lvs_Mensagem) Then
	Return True
Else
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de LOG.", StopSign!)
	Return False
End If
end function

public function boolean of_parametro_conexao_ftp ();String ls_Parametro

ls_Parametro = 'DE_FTP_XML_ENDERECO'

select vl_parametro
Into :is_ftp_xml_endereco
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
		Return False
End Choose

If IsNull(is_ftp_xml_endereco) or is_ftp_xml_endereco = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro + "'.")
	Return False
End If

is_ftp_xml_endereco = Lower(is_ftp_xml_endereco)

ls_Parametro = 'DE_FTP_XML_USUARIO'

select vl_parametro
Into :is_ftp_xml_usuario
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
		Return False
End Choose

If IsNull(is_ftp_xml_usuario) or is_ftp_xml_usuario = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro  + "'.")
	Return False
End If

is_ftp_xml_usuario = Lower(is_ftp_xml_usuario)

ls_Parametro = 'DE_FTP_XML_SENHA'

select vl_parametro
Into :is_ftp_xml_senha
From parametro_geral
Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
		Return False
End Choose

If IsNull(is_ftp_xml_senha) or is_ftp_xml_senha = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro +  "'.")
	Return False
End If

is_ftp_xml_senha = Lower(is_ftp_xml_senha)

Return True
end function

public function boolean of_insere_nf_agendamento_item_lote (string as_chave_acesso, t_prod at_prod, integer ai_item_nf, ref string as_mensagem);Date		ldt_Validade, ldt_Fabricacao, ldt_Atual
Long		ll_Qt_Itens, ll_Produto, ll_Qt_Lote, ll_for
String	ls_Lote, ls_achou


ll_Qt_Itens = UpperBound(at_Prod.med[])

For ll_for = 1 to  ll_Qt_Itens
	ls_Lote 			= at_Prod.med[ll_for].nLote
	ll_Qt_Lote		= at_Prod.med[ll_for].qLote
	ldt_Validade	= at_Prod.med[ll_for].dval
	ldt_Fabricacao	= at_Prod.med[ll_for].dfab
	ldt_Atual		= Date(gf_GetServerDate())
	
	If ldt_Validade =  Date("1900-01-01") Then SetNull(ldt_Validade)
	
	//A data de validade deve ser considerada sempre como dia 01
	if not IsNull(ldt_Validade) then
		ldt_Validade	= Date("01/" + MidA(String(ldt_Validade), 4))
	end if
	
	If ldt_Fabricacao =  Date("1900-01-01") Then SetNull(ldt_Fabricacao)
	
	//Se a data de fabrica$$HEX2$$e700e300$$ENDHEX$$o for maior ou igual a data de validade, o sistema altera a data de fabrica$$HEX2$$e700e300$$ENDHEX$$o para o primeiro dia do m$$HEX1$$ea00$$ENDHEX$$s da validade pra n$$HEX1$$e300$$ENDHEX$$o gerar problema no Mult
	If ldt_Fabricacao >= ldt_Validade Then
		ldt_Fabricacao = Date("01/" + MidA(String(ldt_Validade), 4))
	End If
	
	If ldt_Fabricacao > ldt_Atual Then
		ldt_Fabricacao = ldt_Atual
	End If
	
	ls_Lote = gf_Replace(ls_Lote, "|", "", 0)
		
	select de_chave_acesso
     into :ls_achou
     from nf_agendamento_ent_item_lote
	 where de_chave_acesso 	= :as_Chave_Acesso
		and nr_item					= :ai_item_nf
		and nr_lote					= :ls_Lote
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		  	update nf_agendamento_ent_item_lote  
		  		set qt_lote =  :ll_Qt_Lote
			 where de_chave_acesso 	= :as_Chave_Acesso
				and nr_item					= :ai_item_nf
				and nr_lote					= :ls_Lote
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do lote do item " +  string(ai_item_nf) + " da chave de acesso '" + as_Chave_Acesso + "': " + SqlCa.SqlErrText
				SqlCa.of_RollBack();
				Return False
			End If
		Case 100
			insert into nf_agendamento_ent_item_lote (de_chave_acesso,   
																	nr_item,   
																	nr_lote,   
																	qt_lote,   
																	dh_validade,   
																	dh_fabricacao)  
														  values (:as_chave_acesso,	//de_chave_acesso,   
																	 :ai_item_nf,			//nr_item,   
																	 :ls_Lote,				//nr_lote,   
																	 :ll_Qt_Lote,			//qt_lote,   
																	 :ldt_Validade,		//dh_validade,   
																	 :ldt_Fabricacao)		//dh_fabricacao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_mensagem = "Inclus$$HEX1$$e300$$ENDHEX$$o do lote do item " +  string(ai_item_nf) + " da chave de acesso '" + as_Chave_Acesso + "': " + SqlCa.SqlErrText
				SqlCa.of_RollBack();
				Return False
			End If
		Case -1
			as_mensagem = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do lote do item " +  string(ai_item_nf) + " da chave de acesso '" + as_Chave_Acesso + "': " + SqlCa.SqlErrText
			SqlCa.of_RollBack();
			Return False
	End Choose
Next

Return True
end function

public function boolean of_insere_nf_agendamento_titulo (t_infnfe at_infnfe, string as_chave_acesso, ref string as_mensagem_log);Boolean lb_STACRUZ = False

Long ll_Qt_Titulos, i, ll_Achou
Date ldt_Emissao, ldt_Vencimento
String ls_Nr_Titulo_Pagar
Double ld_Vl_Pagar
String ls_Alfabeto, ls_Nosso_Numero, ls_CNPJ_For, ls_Achou

ll_Qt_Titulos = UpperBound(at_infnfe.cobr.dup[])
ldt_Emissao = at_infnfe.ide.demi 
ls_Alfabeto = "ABCDEFGHIJKLMNOPQRSTUVXZYW"

as_mensagem_log = ""

ls_CNPJ_For	 = 	at_infnfe.emit.cnpj

Select count(*)
Into :ll_Achou
From fornecedor
Where cd_fornecedor in ('053403312', '053405539', '053400519', '053405356', '053405860' )
	and nr_cgc = :ls_CNPJ_For
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_mensagem_log = "Erro ao validar a parcela de t$$HEX1$$ed00$$ENDHEX$$tulos: "+ SqlCa.SqlErrText
	SqlCa.of_RollBack()
	Return False
ElseIf ll_Achou > 0 Then
	lb_STACRUZ = True
End If

//Valida Parcelas Titulos 
// Retirado 
//If Not of_valida_parcelas_titulo( at_infnfe, lb_STACRUZ , Ref as_mensagem_log ) Then Return True

For i = 1 to  ll_Qt_Titulos

	ls_Nr_Titulo_Pagar	= Left(String(il_Nota)+is_Serie+Mid(ls_Alfabeto, i, 1), 10)
	ldt_Vencimento 		= at_infnfe.cobr.dup[ i ].dvenc
	
	//Tratamento StCruz, o valor do t$$HEX1$$ed00$$ENDHEX$$tulo ser$$HEX1$$e100$$ENDHEX$$ o proprio valor da nota fiscal
	If lb_STACRUZ Then
		ld_Vl_Pagar			= at_infnfe.total.ICMSTot.vNF
	Else
		ld_Vl_Pagar			= at_infnfe.cobr.dup[ i ].vdup
	End If
	
	SELECT de_chave_acesso  
    INTO :ls_Achou  
    FROM nf_agendamento_ent_titulo
	Where de_chave_acesso = :as_chave_acesso
		and nr_titulo_pagar = :ls_Nr_Titulo_Pagar
	Using Sqlca;
	
	Choose Case SqlCa.SqlCode 
		Case 0
		Case 100
			
			INSERT INTO nf_agendamento_ent_titulo  ( de_chave_acesso,   
																	  nr_titulo_pagar,   
																	  dh_emissao,   
																	  dh_vencimento,   
																	  vl_pagar )  
			VALUES ( :as_chave_acesso,				//de_chave_acesso,   
						:ls_Nr_Titulo_Pagar,				//nr_titulo_pagar,   
						:ldt_Emissao,						//dh_emissao,   
						:ldt_Vencimento,					//dh_vencimento,   
						:ld_Vl_Pagar)						//vl_pagar)  ;
			Using SqlCa;
			
			If SqlCa.SqlCode  = -1 Then
				as_Mensagem_Log = "Erro ao inserir os t$$HEX1$$ed00$$ENDHEX$$tulos da nota: "+ SqlCa.SqlErrText
				Return False
			End If
						
		Case -1
			as_Mensagem_Log = "Erro ao localizar os t$$HEX1$$ed00$$ENDHEX$$tulos da nota: "+ SqlCa.SqlErrText
			Return False
	End Choose
	
	If lb_STACRUZ Then
		//StCruz gravar$$HEX1$$e100$$ENDHEX$$ somente 1 registro...
		Exit
	End If
Next

Return True
end function

public function boolean of_valida_parcelas_titulo (t_infnfe at_infnfe, boolean ab_stacruz, ref string as_mensagem);Long ll_Qt_Titulos, i, ll_Achou
decimal ld_Total_Parcelas
String ls_Texto_Email, ls_CNPJ_For
Boolean lb_Sucesso = True

ls_CNPJ_For	 = 	at_infnfe.emit.cnpj

//If as_fornecedor = "053403312" or as_fornecedor = '053405539' or as_fornecedor = '053400519' or as_fornecedor = '053405356' or as_fornecedor = '053405860' Then Return True

il_Filial = 534

If ab_stacruz Then 	Return True

//ls_CNPJ_For	 = 	at_infnfe.emit.cnpj
//
//Select count(*)
//Into :ll_Achou
//From fornecedor
//Where cd_fornecedor in ('053403312', '053405539', '053400519', '053405356', '053405860' )
//	and nr_cgc = :ls_CNPJ_For
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	as_Mensagem = "Erro ao validar a parcela de t$$HEX1$$ed00$$ENDHEX$$tulos: "+ SqlCa.SqlErrText
//	SqlCa.of_RollBack()
//	Return False
//ElseIf ll_Achou > 0 Then
//	Return True
//End If

ll_Qt_Titulos = UpperBound( at_infnfe.cobr.dup[] )
						
ls_Texto_Email = "<br><br><table><tr><td>Filial:</td><td>" + String(il_Filial) +"</td>" + &
	"<tr><td>Fornecedor:</td><td>"				+ ls_CNPJ_For					+ "</td>" + &
	"<tr><td>Nr NF:</td><td>"						+ String(at_infnfe.ide.nNf)		+ "</td>" + &
	"<tr><td>Chave NF:</td><td>" 					+  at_infnfe.id						+ "</td></table>"					

For i = 1 To ll_Qt_Titulos
	ld_Total_Parcelas += Dec(at_infnfe.cobr.dup[ i ].vdup)
Next

Try

	ld_Total_Parcelas = Round(ld_Total_Parcelas, 2)
	
	//corrigir o problema na concilia$$HEX2$$e700e300$$ENDHEX$$o da MULTI
	If (ld_Total_Parcelas - Round(dec(at_infnfe.total.ICMSTot.vNF), 2)) > 0.30 Then
		as_mensagem = "O valor do t$$HEX1$$ed00$$ENDHEX$$tulo [" + String( ld_Total_Parcelas ) + "] $$HEX1$$e900$$ENDHEX$$ maior que o valor total da NF [" + String( at_infnfe.total.ICMSTot.vNF ) + "]"	
		lb_Sucesso = False
		Return lb_Sucesso
	End If
	
	//Desconto concedido na parcela
	//O abatimento deve ocorrer diretamente no sistema da MULTI
	If ll_Qt_Titulos = 1 Then
		If  (Round(dec(at_infnfe.total.ICMSTot.vNF), 2) - ld_Total_Parcelas) > 0.30  Then
			as_mensagem = "O valor do t$$HEX1$$ed00$$ENDHEX$$tulo [" + String( ld_Total_Parcelas ) + "] $$HEX1$$e900$$ENDHEX$$ menor que o valor total da NF [" + String( at_infnfe.total.ICMSTot.vNF ) + "]" + &
										"<br> - Titulo corrigido pelo valor total da NF."
			at_infnfe.cobr.dup[ 1 ].vdup = at_infnfe.total.ICMSTot.vNF
			lb_Sucesso = True
		End If
	Else
		as_mensagem = "Divergencia na qtde. de parcela [ " + String( ll_Qt_Titulos ) + " ]"
		
		//Duas ou mais Parcelas e mesmo assim o valor $$HEX1$$e900$$ENDHEX$$ menor que o valor Total NF
		If (Round(dec(at_infnfe.total.ICMSTot.vNF), 2) - ld_Total_Parcelas) > 0.30 Then 
			lb_Sucesso = False
		Else
			lb_Sucesso = True
		End If
	End If

Finally
	
	If Not IsNull(as_mensagem) And as_mensagem <> "" Then gf_ge202_envia_email_automatico(19, '', as_mensagem + ls_Texto_Email, {''} )
	
	Return lb_Sucesso
End Try

end function

public function boolean of_nf_agendamento_ent_divergencia ();Return true
end function

private function boolean of_grava_divergencia_agend (string as_divergencia, long al_tipo_divergencia, string as_de_produto, string as_cod_barras, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_xml);//dc_uo_transacao 	lo_SqlCa

Boolean lb_Ja_Tem = False

Date ldt_Atual

Long ll_Divergencia, ll_Nr_Divergencia_2
Long ll_Nr_Divergencia, ll_Proximo_Seq
Long ll_Linha
Long ll_Tipo_Divergencia_Aux

String ls_Divergencia, ls_Achou
String ls_De_Produto
String ls_Mensagem_Div_Email
String ls_Mensagem_Log

//Disconnect Using This;

//13 - Produto marcado para n$$HEX1$$e300$$ENDHEX$$o considerar a meta de compra

//Diverg$$HEX1$$ea00$$ENDHEX$$ncia de valor maior do que 15%
If al_Tipo_divergencia = 1000 Then
	ll_Tipo_Divergencia_Aux = al_Tipo_divergencia
	al_Tipo_divergencia		= 1
End If

try
	
	If Not This.of_abre_conexao_log(ref as_Mensagem_Log) Then Return False
	
	//lo_SqlCa	= create dc_uo_transacao
	//lo_SqlCa.ivs_database = "SYBASE"
		
	//If lo_SqlCa.of_Connect(gvo_Aplicacao.ivs_DataSource, gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_Aplicacao.of_UserId(), False) Then
		
		Choose Case al_Tipo_Divergencia
			Case 3 
				ls_Divergencia = "Produto com quantidade fracionada"
			Case 6  
				ls_Divergencia = "Nao foi localizado o codigo do produto com EAN do XML"
			Case 7  
				ls_Divergencia = "Produto esta sem o codigo de barras no XML"
			Case 8  
				ls_Divergencia = "Produto nao localizado no pedido"
			Case 9  
				ls_Divergencia = "Quantidade recebida maior do que quantidade pedida"
			Case 10  
				ls_Divergencia = "Situacao Tributaria incorreta"
			Case Else
				ls_Divergencia = as_Divergencia				
		End Choose
		
		as_Divergencia = Upper(as_Divergencia)
		
		//12 $$HEX1$$e900$$ENDHEX$$ divergencia de pedido, 2 divergencia de fornecedor do pedido
		If (al_Tipo_Divergencia = 12) or (al_Tipo_Divergencia = 2) Then 
			
			This.of_grava_log_receb_sap(string(al_tipo_divergencia, '00') + ' - ' + as_divergencia, 0, ref as_Mensagem_Log)
			
			SELECT de_chave_acesso
			Into :ls_Achou
				FROM nf_agendamento_ent_divergencia 
			Where de_chave_acesso = :as_chave_acesso
				and cd_tipo_divergencia = :al_tipo_divergencia
			Using iuo_SqlCa_log;
			
			Choose Case iuo_SqlCa_log.SqlCode
				Case 0
				Case 100
					
					INSERT INTO nf_agendamento_ent_divergencia  ( de_chave_acesso, cd_tipo_divergencia, de_divergencia )  
					VALUES (:as_chave_acesso,  :al_tipo_divergencia, :as_divergencia)
					Using iuo_SqlCa_log;
					
					If iuo_SqlCa_log.SqlCode = -1 Then
						as_Mensagem_Log = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da diverg$$HEX1$$ea00$$ENDHEX$$ncia [nf_agendamento_ent_divergencia]. " + SqlCa.SqlErrText
						iuo_SqlCa_log.of_Rollback()
						Return False	
					End If

					ivs_Divergencias_Agend[ UpperBound(ivs_Divergencias_Agend[])+1 ] = as_Divergencia
					
				Case -1 
					as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da diverg$$HEX1$$ea00$$ENDHEX$$ncia [nf_agendamento_ent_divergencia]. " + SqlCa.SqlErrText
					iuo_SqlCa_log.of_Rollback()
					Return False	
			End Choose
			
			If Not of_grava_historico_divergencia_agend(as_chave_acesso, al_tipo_divergencia, as_divergencia, iuo_SqlCa_log, Ref ls_Mensagem_Log) Then
				as_Mensagem_Log = ls_Mensagem_Log
				Return False
			End If
			
		Else

			ls_Mensagem_Div_Email = "<br><br>EAN: " + as_cod_barras + "<br>" + &
									"Produto: " + as_De_Produto + "<br>" + &
									"Diverg$$HEX1$$ea00$$ENDHEX$$ncia: " + as_Divergencia
	
			
			This.of_grava_log_receb_sap(string(al_tipo_divergencia, '00') + ' - ' + as_divergencia, ai_item_xml, ref as_Mensagem_Log)
			
			SELECT de_chave_acesso
			INTO :ls_Achou
				FROM nf_agendamento_ent_item_diverg
			Where de_chave_acesso 	= :as_chave_acesso
				and nr_item 				= :ai_item_xml
				and cd_tipo_divergencia 	= :al_tipo_divergencia
			Using iuo_SqlCa_log;
					
			If iuo_SqlCa_log.SqlCode = -1 Then
				as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da diverg$$HEX1$$ea00$$ENDHEX$$ncia [nf_agendamento_ent_item_divergencia]. " + SqlCa.SqlErrText
				iuo_SqlCa_log.of_Rollback()
				Return False	
			End If
			
			Choose Case iuo_SqlCa_log.SqlCode
				Case 0
				Case 100
					
					  INSERT INTO nf_agendamento_ent_item_diverg  (	de_chave_acesso,  nr_item, cd_tipo_divergencia,  de_divergencia )  
					  VALUES ( :as_chave_acesso,  :ai_item_xml, :al_tipo_divergencia, :as_divergencia )
					  Using iuo_SqlCa_log;
								  
						If iuo_SqlCa_log.SqlCode = -1 Then
							as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da diverg$$HEX1$$ea00$$ENDHEX$$ncia [nf_agendamento_ent_item_divergencia]. " + SqlCa.SqlErrText
							iuo_SqlCa_log.of_Rollback()
							Return False	
						End If

						If ll_Tipo_Divergencia_Aux = 1000 Then
							ivs_Divergencias_Agend_Nao_Fornec[ UpperBound(ivs_Divergencias_Agend_Nao_Fornec[])+1 ] = ls_Mensagem_Div_Email
						Else
							ivs_Divergencias_Agend[ UpperBound(ivs_Divergencias_Agend[])+1 ] = ls_Mensagem_Div_Email
						End If
						
						//Se existir diverg$$HEX1$$ea00$$ENDHEX$$ncia de tributa$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ enviado e-mail com c$$HEX1$$f300$$ENDHEX$$pia para o setor Fiscal
						If al_Tipo_Divergencia = 10 Then
							ib_Envia_Email_Fiscal = True
						End If
					
				Case -1
					as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da diverg$$HEX1$$ea00$$ENDHEX$$ncia [nf_agendamento_ent_item_divergencia]. " + SqlCa.SqlErrText
					iuo_SqlCa_log.of_Rollback()
					Return False
			End Choose
			
			If Not of_grava_historico_divergencia_agend(as_chave_acesso, al_tipo_divergencia, as_divergencia, iuo_SqlCa_log, Ref ls_Mensagem_Log) Then
				as_Mensagem_Log = ls_Mensagem_Log
				Return False
			End If
			
		End If
			
		iuo_SqlCa_log.of_Commit()
		
	//End If	 
	
finally
//	lo_SqlCa.of_Disconnect()
//	Destroy(lo_SqlCa)	
end try
	 
Return True
end function

public function boolean of_valida_produtos_pedido (string as_chave_acesso, long al_pedido, string as_cgc_forn, ref string as_mensagem);String	ls_Cgc_Pedido,&
		ls_Cgc_Xml,&
		ls_Ean,&
		ls_Tributacao_Icms,&
		ls_CProd,&
		ls_Ean_Trib,&
		ls_Xprod
		
Long	ll_Qt_Itens,&
		i,&
		ll_Produto,&
		ll_Qtde,&
		ll_Nf,&
		ll_NrItemPed,&
		ll_Achou,&
		ll_Produto_Reb,&
		ll_Seq_XML_Reb,&
		ll_Seq_XML_Agend
		
		
Decimal	ldc_Icms,&
			ldc_Icms_St,&
			ldc_Qt_produto

dc_uo_ds_base lds

try
	
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject('ds_ge238_nf_agendamento_item', False) Then
		as_mensagem = "Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW [ds_ge238_nf_agendamento_item]."
		Return False
	End If	
	
	If lds.Retrieve(as_chave_acesso) = -1 Then
		as_mensagem = "Erro ao recuperar os dados da DW [ds_ge238_nf_agendamento_item]."
		Return False
	End If
	
	ll_Qt_Itens = lds.RowCount()
		
	For i = 1 to  ll_Qt_Itens
		
		SetNull(ll_Produto)
		
		ll_NrItemPed				= lds.Object.nr_item_pedido			[i]
		ls_CProd 					= lds.Object.cd_cprod					[i]
		ls_Ean						= lds.Object.de_codigo_barras			[i]
		ls_Ean_Trib					= lds.Object.de_codigo_barras_trib	[i]
		ls_Xprod						= lds.Object.de_produto					[i]
		ll_Produto					= lds.Object.cd_produto					[i]
		ldc_Qt_produto				= lds.Object.qt_faturada					[i]
		ll_Produto_Reb				= lds.Object.cd_produto_reb			[i]
		ll_Seq_XML_Reb			= lds.Object.nr_item_xml_receb		[i]
		ll_Seq_XML_Agend		= lds.Object.nr_sequencial				[i]
		
	
		
		If IsNull(ll_Produto) Then
			If Not of_Valida_Produto_Xml(	ll_NrItemPed, ls_CProd, ls_Ean,ls_Ean_Trib, &
													as_cgc_forn, ls_Xprod, ldc_Qt_produto,& 
													Ref as_mensagem, as_chave_acesso, i, ref ll_Produto, True) Then
				Return False
			End If
			
			// Se n$$HEX1$$e300$$ENDHEX$$o conseguir achar um produto o sistema ir$$HEX1$$e100$$ENDHEX$$ considerar o produto que veio na RECEBIMENTO_SAP_ITEM
			If ib_Iniciado_Operacao_SAP and IsNull(ll_Produto) Then ll_Produto = ll_Produto_Reb
		End If
		
		If ib_Iniciado_Operacao_SAP Then
			
			If IsNull(ll_Seq_XML_Agend) 	Then ll_Seq_XML_Agend	= 0 
			If IsNull(ll_Seq_XML_Reb) 		Then ll_Seq_XML_Reb 	= 0
			
			If IsNull(ll_Produto_Reb) or ll_Produto_Reb = 0 Then
				as_mensagem = "O SAP n$$HEX1$$e300$$ENDHEX$$o enviou o c$$HEX1$$f300$$ENDHEX$$digo do produto no item '"  + String(ll_Seq_XML_Reb) + "'."
				Return False
			End If

			// Se o GN n$$HEX1$$e300$$ENDHEX$$o localizou o produto, ser$$HEX1$$e100$$ENDHEX$$ utilizado c$$HEX1$$f300$$ENDHEX$$digo do SAP		
			If ll_Produto <> ll_Produto_Reb Then
				as_mensagem = "O PRODUTO CONTIDO NO XML:"+String(ll_Produto)+" ESTA DIFERENTE DO PRODUTO SAP:"+String(ll_Produto_Reb)
				This.of_grava_log_receb_sap(as_mensagem , ll_Seq_XML_Reb  , as_mensagem)
				Return False
			End If
			
		End If
		
		// Quando vier do SAP o campo ser$$HEX1$$e100$$ENDHEX$$ sempre preenchido
		//Se j$$HEX1$$e100$$ENDHEX$$ tiver o c$$HEX1$$f300$$ENDHEX$$digo do produto n$$HEX1$$e300$$ENDHEX$$o tenta localizar novamente. O c$$HEX1$$f300$$ENDHEX$$digo j$$HEX1$$e100$$ENDHEX$$ foi localizado.
		UPDATE nf_agendamento_ent_item  
			SET cd_produto = :ll_Produto
		Where de_chave_acesso = :as_chave_acesso
			and nr_item	= :i
			and (cd_produto is null or cd_produto <> :ll_Produto)
		Using SqlCa;
		  
		If SqlCa.SqlCode = -1 Then
			as_mensagem = "Erro atualiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do produto no item. " + SqlCa.SqlErrText
			SqlCa.of_RollBack()
			Return False
		End If		
						
	Next

finally
	Destroy lds
end try

If Not This.of_valida_produto_pedido(as_chave_acesso, al_pedido, as_cgc_forn, ref as_mensagem ) Then Return False

Return True
end function

private function boolean of_grava_divergencia (string as_divergencia, long al_tipo_divergencia, string as_de_produto, string as_cod_barras, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_nf);If Not IsNull(as_chave_acesso) and Trim(as_chave_acesso) <> '' Then
	Return of_grava_divergencia_Agend(as_divergencia, 	al_tipo_divergencia, as_de_produto, as_cod_barras, as_mensagem_log, as_chave_acesso, ai_item_nf)
Else
	Return of_grava_divergencia(as_divergencia, 	al_tipo_divergencia, as_de_produto, as_cod_barras, as_mensagem_log)
End If


	
end function

public function boolean of_valida_cnpj_fornecedor (string as_cgc_fornecedor, long al_pedido, ref string as_mensagem_log, string as_chave_acesso);DateTime	ldt_dh_inicio_nf_remessa, ldt_atual
String ls_Cgc_Pedido


select b.nr_cgc 
Into :ls_Cgc_Pedido
from pedido_central a
inner join fornecedor b on b.cd_fornecedor = a.cd_fornecedor
where a.nr_pedido = :al_Pedido
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		If ls_Cgc_Pedido <> as_cgc_fornecedor Then
			select c.nr_cgc,
					 b.dh_inicio_nf_remessa
			Into :ls_Cgc_Pedido,
				  :ldt_dh_inicio_nf_remessa
			from pedido_central a
			inner join fornecedor b on b.cd_fornecedor = a.cd_fornecedor
			inner join fornecedor c on c.cd_fornecedor = b.cd_fornecedor_nf_remessa
			where a.nr_pedido = :al_Pedido
			Using SqlCa;
			
			Choose Case SQLCA.SQLCode
				Case 0
					ldt_atual = gf_getserverdate()
					
					if ldt_atual > ldt_dh_inicio_nf_remessa then
						If ls_Cgc_Pedido <> as_cgc_fornecedor Then
							If Not of_grava_divergencia("O CNPJ do emissor da nota ("+as_cgc_fornecedor+") $$HEX1$$e900$$ENDHEX$$ diferente do fornecedor do pedido ("+ls_Cgc_Pedido+")", 2, "", "", Ref as_Mensagem_Log, as_chave_acesso, 0 ) Then
								Return False
							End If
							
							ib_Diverg_Ped_Trocado = True
						end if
					else
						If Not of_grava_divergencia("O CNPJ do emissor da nota ("+as_cgc_fornecedor+") $$HEX1$$e900$$ENDHEX$$ diferente do fornecedor do pedido ("+ls_Cgc_Pedido+")", 2, "", "", Ref as_Mensagem_Log, as_chave_acesso, 0 ) Then
							Return False
						End If
					
						ib_Diverg_Ped_Trocado = True
					end if				
				Case -1
					as_Mensagem_Log = "Localizar o CNPJ do fornecedor do pedido. " + SqlCa.SqlErrText
					Return False
				Case 100
					If Not of_grava_divergencia("O CNPJ do emissor da nota ("+as_cgc_fornecedor+") $$HEX1$$e900$$ENDHEX$$ diferente do fornecedor do pedido ("+ls_Cgc_Pedido+")", 2, "", "", Ref as_Mensagem_Log, as_chave_acesso, 0 ) Then
						Return False
					End If
					
					ib_Diverg_Ped_Trocado = True
			End Choose	
		End If
	Case 100
		If Not IsNull(al_Pedido) Then
			If Not of_grava_divergencia("N$$HEX1$$e300$$ENDHEX$$o foi localizado o CNPJ do fornecedor do pedido '"+String(al_Pedido)+"'", 2, "", "", Ref as_Mensagem_Log, as_chave_acesso, 0 ) Then
				Return False
			End If
		End If	
	Case -1
		as_Mensagem_Log = "Localizar o CNPJ do fornecedor do pedido. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_marca_verificado_divergencia_ped (string as_chave_acesso, integer ai_log, string as_index_destinadas);Boolean lb_Sucesso = True

String ls_MSG

Update nfe_indexacao
Set id_verificado_divergencia_ped = 'S'
Where id_nf =:as_chave_acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro ao atualizar o campo 'id_verificado_divergencia_ped' de uma das tabelas NFE_INDEXACAO.'" + SqlCa.SqlErrText
	of_Grava_Log(ai_log, ls_MSG)
	lb_Sucesso = False
End If

If lb_Sucesso Then
	
	Update nfe_destinadas
	Set id_verificado_divergencia_ped = 'S'
	Where de_chave_acesso =:as_chave_acesso
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG = "Erro ao atualizar o campo 'id_verificado_divergencia_ped' de uma das tabelas NFE_DESTINADAS.'" + SqlCa.SqlErrText
		of_Grava_Log(ai_log, ls_MSG)
		lb_Sucesso = False
	End If
End If

If lb_Sucesso Then
	SqlCa.of_Commit();
Else
	SqlCa.of_RollBack();
End If

Return lb_Sucesso
end function

public function boolean of_libera_nf_para_agendamento (string as_chave_acesso, ref string as_mensagem_log);Long	ll_Qt_Divergencia_Nota,&
		ll_Qt_Divergencia_produto
		
String		ls_Erro,&
			ls_Operador
			
DateTime ldh_Envio_Site

SetNull(ldh_Envio_Site)
		
Select		(select count(*) from nf_agendamento_ent_divergencia x where x.de_chave_acesso = a.de_chave_acesso) qt_divergencia_nota,
			(select count(*) from nf_agendamento_ent_item_diverg z where z.de_chave_acesso = a.de_chave_acesso) qt_divergencia_produto
Into	:ll_Qt_Divergencia_Nota,
		:ll_Qt_Divergencia_produto
from nf_agendamento_ent a
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Mensagem_Log = "Erro ao verificar se ainda existe diverg$$HEX1$$ea00$$ENDHEX$$ncias: "+ SqlCa.SQLErrText
		Return False
	Case -1
		as_Mensagem_Log = "Erro ao verificar se ainda existe diverg$$HEX1$$ea00$$ENDHEX$$ncias: "+ SqlCa.SQLErrText
		Return False
End Choose


If (ll_Qt_Divergencia_Nota = 0) and (ll_Qt_Divergencia_produto = 0) Then
	
	ls_Operador	= gvo_aplicacao.ivo_seguranca.nr_matricula
	
	If ls_Operador = "" Then ls_Operador = "14330"
	
	Update nf_agendamento_ent
	Set 	dh_liberacao_agendamento		= getdate(), 
			nr_matricula_lib_agendamento	= :ls_Operador
	Where de_chave_acesso = :as_Chave_Acesso
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_RollBack()
		as_Mensagem_Log = "Erro ao liberar a nota para agendamento: "+ ls_Erro
		Return False
	End If	
		
	This.of_executa_commit()
End If


Return True
end function

public function boolean of_inclui_pedido_pbm (t_infnfe at_infnfe, ref long al_pedido, ref string as_mensagem_log, string as_chave, ref boolean ab_erro);Decimal ldc_Limite_Maximo

Long ll_Pedido
Long ll_Condicao_Fornecedor
Long ll_Condicao
Long ll_Dias

String ls_Mensagem_Erro
String ls_CNPJ
String ls_Fornecedor
String ls_Situacao = "C"
String ls_Comprador
String ls_Email_Comprador
String ls_PBM

ab_erro = False

If ib_Pedido_Ba Then
	ls_PBM = "N"
Else
	ls_PBM = "S"
End If

Try
	//Verifica Emitente
	ls_CNPJ = at_infnfe.Emit.cnpj
	
	Select nr_pedido
	Into :al_pedido
	From pedido_central
	Where de_chave_acesso_nfe = :as_chave
		and id_pbm = :ls_PBM
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Return True
		Case 100
					
			Select a.nr_pedido
			Into :al_pedido
			From pedido_central_chave_acesso_nf a
			inner join pedido_central p on p.nr_pedido = a.nr_pedido
			Where a.de_chave_acesso = :as_chave
				 and p.id_pbm = :ls_PBM
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					Return True
				Case 100
				Case -1
					ab_erro = True
					as_mensagem_log = "Erro na consulta do pedido PBM " + as_Chave + ". " + SqlCa.SqlErrText
					Return False
			End Choose
			
		Case -1
			ab_erro = True
			as_mensagem_log = "Erro na consulta do pedido PBM " + as_Chave + ". " + SqlCa.SqlErrText
			Return False
	End Choose
	
	Select cd_fornecedor, cd_condicao_pagamento, nr_matricula_comprador
	Into :ls_Fornecedor, :ll_Condicao_Fornecedor, :ls_Comprador
	From fornecedor
	where nr_cgc  			= :ls_CNPJ
	and id_distribuidora 	= 'S'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			Return False
		Case -1
			ab_erro = True
			as_mensagem_log = "Erro ao localizar a distribuidora no cadastro de fornecedor. " + SqlCa.SqlErrText
			Return False
	End Choose
	
	If Not ib_Pedido_Ba Then
		If ls_Fornecedor <> '053405539' and ls_Fornecedor <> '053402679' and ls_Fornecedor <> '053400528' and ls_Fornecedor <> '053404408' and ls_Fornecedor <> '053405274' Then
			Return False
		End If
		
	Else
		If Not of_Verifica_Distribuidora_SC(ls_Fornecedor, Ref as_Mensagem_Log) Then Return False
	End If
	
	If at_infnfe.det[1].prod.cfop <> '5910' Then
		
		ll_Dias = DaysAfter( at_infnfe.ide.demi,  at_infnfe.cobr.dup[1].dvenc )
				
		select top 1 a.cd_condicao 
			Into :ll_condicao
		from condicao_pagamento_parcela a
			inner join condicao_pagamento b 
					  on b.cd_condicao 		= a.cd_condicao
		where a.qt_dias_vencimento 		= :ll_Dias
			 and b.qt_parcelas 				= 1
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				//OK
			Case 100
				ll_Condicao = ll_Condicao_Fornecedor
			Case -1
				ab_erro = True
				as_mensagem_log = "Erro na consulta da condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento utilizando " + String(ll_Dias) + " dias. " + SqlCa.SqlErrText
				Return False
		End Choose
	Else
		// BONIFICADA
		ll_condicao = 50
	End If
	
	If Not ib_Pedido_Ba Then
	
		//Verifica Limite Comprador
		uo_ge219_liberacao_pedido_central lo_Limite
		lo_Limite = Create uo_ge219_liberacao_pedido_central
		
		If Not lo_Limite.of_verifica_valor_maximo_liberacao(ls_Comprador, Ref ldc_Limite_Maximo, Ref ls_Mensagem_Erro) Then
			as_mensagem_log = ls_Mensagem_Erro
			ab_erro = True
			Destroy lo_Limite
			Return False
		End If
		
		If at_infnfe.total.icmstot.vnf >  ldc_Limite_Maximo Then ls_Situacao = 'P'
	End If
									
	If of_Insere_Cabecalho_Pedido_PBM( ls_Fornecedor,ll_condicao, at_infnfe.transp.modfrete, at_infnfe.total.icmstot.vNF, ls_Situacao,at_infnfe.id, Ref ll_Pedido, Ref ls_Mensagem_Erro, at_infnfe, ref ab_erro ) Then
		If ab_erro Then Return False
		If  of_Insere_Itens_Pedido_PBM( ll_Pedido, at_infnfe, Ref ls_Mensagem_Erro, ls_Fornecedor, ref ab_erro ) Then
			If ab_erro Then Return False
			al_Pedido = ll_Pedido
			
			If Not ib_Pedido_Ba Then
				//Enviar um Email p/ comprador
				If ls_Situacao = "P" Then
					If lo_Limite.of_Localiza_Email_Usuario(ls_Comprador, Ref ls_Email_Comprador, Ref ls_Mensagem_Erro ) Then
						of_Envia_Email_PBM( ls_Comprador, ls_Email_Comprador, ll_Pedido, at_infnfe.total.icmstot.vnf )
					End If
				End If
			End If
			
			Return True
		End If
	End If
		
	If Trim(ls_Mensagem_Erro) <> "" Or Not IsNull( ls_Mensagem_Erro ) Then
		as_mensagem_log += ' | ' + ls_Mensagem_Erro
	End If
		
Catch ( runtimeerror  lo_rte )
	as_mensagem_log = "Erro: "+ lo_rte.GetMessage()
Finally
	Destroy lo_Limite
End Try
end function

public function boolean of_insere_cabecalho_pedido_pbm (string as_fornecedor, long al_condicao, long al_tipo_frete, decimal adc_vlped, string as_situacao, string as_chave_acesso, ref long al_pedido, ref string as_mensagem_log, t_infnfe at_infnfe, ref boolean ab_erro);String ls_Frete
String ls_Reposicao_PBM
String ls_PBM
String ls_Observacao
String ls_Uf

ab_erro = False

If Not ib_Pedido_Ba Then
	
	ls_PBM = "S"
	ls_Observacao = "PROC AUTOMATICO INCLUSAO DE PEDIDO PBM"
	SetNull(ls_Uf)

	ls_Reposicao_PBM =  at_infnfe.infadic.xvan
		
	Choose Case as_fornecedor
		Case '053404408'
			If Pos(at_infnfe.infadic.infCpl, "REPOSICAO SEVENPDV") < 1 And Pos(at_infnfe.infadic.infCpl, "REPOSICAO E-PHARMA") < 1 Then
				as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
				Return False
			End If
			
		Case '053405539'
			If ib_marreta_reposicao_sta Then
				ls_Reposicao_PBM = "TRN CENTRE"
			End If
			
			// STCRUZ - faz mais uma verifica$$HEX2$$e700e300$$ENDHEX$$o.
			If ls_Reposicao_PBM <> "TRN CENTRE" And ls_Reposicao_PBM <> "REPOSICAO" Then
				as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
				Return False
			End If

		Case '053400528'			
			If ls_Reposicao_PBM <> 'PHARMALINK' And ls_Reposicao_PBM <> 'REPOSICAO' And ls_Reposicao_PBM <> "SEVEN PDV" Then
				as_mensagem_log += " | Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
				Return False
			End If

		Case '053402679'
			If ls_Reposicao_PBM <> 'FIDELIZE' And ls_Reposicao_PBM <> 'SEVENPDV' Then
				as_mensagem_log += " | Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
				Return False
			End If
			
		Case Else
			
			If ls_Reposicao_PBM <> 'REPOSICAO' and ls_Reposicao_PBM <> "SEVEN PDV" Then
				as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
				Return False
			End If			
	End Choose
	
Else
	ls_PBM = "N"
	ls_Observacao = "PEDIDO DE PRODUTOS EXCLUSIVOS PARA A BAHIA"
	ls_Uf = "BA"
End If

adc_vlped = Round(adc_vlped, 2)

SetNull(ls_Frete)

uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral

lvo_Parametro.ib_Mostra_Mensagem = False

If Not lvo_Parametro.of_Proximo_Sequencial("NR_ULTIMO_PEDIDO_CENTRAL", ref al_Pedido) Then
	as_mensagem_log = lvo_Parametro.is_Mensagem_Log
	ab_erro = True
	Destroy lvo_Parametro
	Return False
End If

Destroy lvo_Parametro

//------------------Tipo Frete CIF/FOB
If al_Tipo_Frete = 0 Then
	ls_Frete = "CIF"
ElseIf al_Tipo_Frete = 1 Then
	ls_Frete = "FOB"
End If

Insert Into pedido_central( 
		nr_pedido,
		dh_pedido,
		dh_emissao,
		dh_previsao_entrega,
		qt_dias_suprimento,
		cd_fornecedor,
		cd_condicao_pagamento,
		pc_desconto,
		vl_total_pedido,
		id_situacao,
		id_programado,
		nr_matricula_cadastramento,
		id_rede,
		cd_filial,
		de_observacao,
		id_pbm,
		id_tipo_frete,
		de_chave_acesso_nfe,
		id_atende_falta_pedido_uf)
Values(	:al_pedido,
			CONVERT( CHAR( 10 ), getdate(), 111 ),
			getDate(),
			CONVERT( CHAR( 10 ), getdate(), 111 ),
			10,
			:as_Fornecedor,
			:al_Condicao,
			0.00,
			:adc_vlped,
			:as_Situacao,
			'N',
			'14330',
			'CIA',
			534,
			:ls_Observacao,
			:ls_PBM,
			:ls_Frete,
			:as_chave_acesso,
			:ls_Uf)
Using SqlCa;
	
If SqlCa.Sqlcode <> 0 Then
	ab_erro = True
	as_mensagem_log = "Erro no insert do cabecalho pedido PBM. " + SqlCa.SqlErrText
	Return False	
End If

Return True
end function

public function boolean of_insere_itens_pedido_pbm (long al_pedido, t_infnfe at_infnfe, ref string as_mensagem_log, string as_fornecedor, ref boolean ab_erro);Boolean lb_PBM
Boolean lb_Reposicao

Decimal ldc_pc_desconto
Decimal ldc_Preco_UN
Decimal ldc_vlUn

Long ll_Total_Itens
Long ll_Row
Long ll_Faturada
Long ll_Produto
Long ll_qtPedida
Long ll_qt_embalagem_padrao_distrib

String ls_EAN
String ls_Mensagem_Log
String ls_Insert_Update
String ls_Reposicao_PBM
String ls_Ean_Trib

ab_erro = False
	
ll_Total_Itens = UpperBound(at_infnfe.det[])

// Retirar esta variavel
//lb_Reposicao = False

//ls_Reposicao_PBM =  at_infnfe.infadic.xvan

// Profarma
//If as_fornecedor = '053404408' Then
//	If Pos(at_infnfe.infadic.infCpl, "REPOSICAO SEVENPDV ") < 1 Then
//		as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
//		Return False	
//	End If
//ElseIf ls_Reposicao_PBM <> 'REPOSICAO' and ls_Reposicao_PBM <> "SEVEN PDV" Then
//	
//	If as_Fornecedor = '053405539' Then
//		If ib_marreta_reposicao_sta Then
//			ls_Reposicao_PBM = "TRN CENTRE"
//		End If
//	End If
//	
//	// STCRUZ - faz mais uma verifica$$HEX2$$e700e300$$ENDHEX$$o.
//	If as_Fornecedor = '053405539' Then
//		If ls_Reposicao_PBM <> "TRN CENTRE" Then
//		
//		//If Pos(at_infnfe.infadic.infCpl, "Lilly_PBM") < 1 Then
//			as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
//			Return False	
//		End If
//	Else
//		as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
//		Return False	
//	End If
//End If

// Transferido para a grava$$HEX2$$e700e300$$ENDHEX$$o do cabe$$HEX1$$e700$$ENDHEX$$alho
//Choose Case as_fornecedor
//	Case '053404408'
//		If Pos(at_infnfe.infadic.infCpl, "REPOSICAO SEVENPDV ") < 1 Then
//			as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
//			Return False	
//		End If
//		
//	Case '053405539'
//		If ib_marreta_reposicao_sta Then
//			ls_Reposicao_PBM = "TRN CENTRE"
//		End If
//		
//		// STCRUZ - faz mais uma verifica$$HEX2$$e700e300$$ENDHEX$$o.
//		If ls_Reposicao_PBM <> "TRN CENTRE" And ls_Reposicao_PBM <> "REPOSICAO" Then
//			as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
//			Return False	
//		End If
//		
//	Case '053400528'
//		
//		If ls_Reposicao_PBM <> 'PHARMALINK' And ls_Reposicao_PBM <> 'REPOSICAO' And ls_Reposicao_PBM <> "SEVEN PDV" Then
//			as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
//			Return False	
//		End If
//		
//	Case Else
//		
//		If ls_Reposicao_PBM <> 'REPOSICAO' and ls_Reposicao_PBM <> "SEVEN PDV" Then
//			as_mensagem_log = "Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM n$$HEX1$$e300$$ENDHEX$$o prevista ' (Fornecedor: " + as_fornecedor + " ) - O Compras deve gerar um pedido"
//			Return False
//		End If
//		
//End Choose

For ll_Row = 1 To ll_Total_Itens
	
	ls_Mensagem_Log		= ""
	lb_PBM 					= False
	ldc_pc_desconto 		= 0
	ldc_Preco_UN			= 0
	
	ls_EAN 		= trim(at_infnfe.det[ ll_Row ].prod.cEAN)
	ls_Ean_Trib	= trim(at_Infnfe.det[ ll_Row ].prod.ceantrib)
	
//	ll_Cod_Produto_Pedido	= at_infnfe.det[i].prod.nitemped
//	ls_Produto_Distribuidora 	= at_Infnfe.det[i].prod.cprod
//	ls_Ean						= trim(at_Infnfe.det[i].prod.cean)
//	ls_Ean_Trib					= trim(at_Infnfe.det[i].prod.ceantrib)
//	ls_Cgc_Fornecedor		= at_Infnfe.emit.cnpj
//	ls_Xprod						= at_Infnfe.det[i].prod.xprod
//	ldc_Qt_produto				= at_Infnfe.det[i].prod.qcom
		
//Nosso cod produto
//	If Not of_Nosso_Codigo_Produto(at_infnfe.det[ ll_Row ].prod.xprod, ls_EAN, at_infnfe.det[ ll_Row ].prod.cEANTrib, Ref ll_Produto, Ref ls_Mensagem_Log) Then
	If Not of_Valida_Produto_Xml(at_infnfe.det[ll_Row].prod.nitemped, at_Infnfe.det[ll_Row].prod.cprod, ls_EAN, ls_Ean_Trib, at_Infnfe.emit.cnpj, at_Infnfe.det[ll_Row].prod.xprod,  at_Infnfe.det[ll_Row].prod.qcom, Ref ls_Mensagem_Log, '', 0, ref ll_Produto, True) Then
		as_mensagem_log = ls_Mensagem_Log
		ab_erro = True
		Return False
	End If
	
	ll_Faturada			= Long( at_infnfe.det[ ll_Row ].prod.qCom )
	
	//Verifica se o produto est$$HEX1$$e100$$ENDHEX$$ relacionado na distribuidora
	If ib_Pedido_Ba Then
		If Not of_Nosso_Codigo_Produto_Distrib(as_Fornecedor, ll_Produto, Ref ls_Mensagem_Log, Ref ll_qt_embalagem_padrao_distrib) Then
			as_Mensagem_Log = ls_Mensagem_Log
			ab_Erro = True
			Return False
		End If
		
		If Not of_Atualiza_Pedido_Distribuidora_Produto(ll_Produto, ll_Faturada,'', Ref ls_Mensagem_Log, ll_qt_embalagem_padrao_distrib) Then
			as_Mensagem_Log = ls_Mensagem_Log
			ab_Erro = True
			Return False
		End If
	End If
	
	if IsNull(ll_qt_embalagem_padrao_distrib) or ll_qt_embalagem_padrao_distrib <= 0 then
		ll_qt_embalagem_padrao_distrib	= 1
	end if
	
	//Verifica Insert/Update
	Select qt_pedida, vl_preco_unitario
		Into :ll_qtPedida, :ldc_vlUn
		From pedido_central_produto
	Where nr_pedido 	= :al_Pedido
		and cd_produto 	= :ll_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			ls_Insert_Update = "U"
		Case 100
			ls_Insert_Update = "I"
		Case -1
			ab_erro = True
			as_mensagem_log = "Erro na consulta 'pedido_central_produto' ( " + String(al_Pedido) + " - " + String( ll_Produto ) + " ) . " + SqlCa.SqlErrText
			Return False	
	End Choose

	ldc_Preco_UN		= Round(at_infnfe.det[ ll_Row ].prod.vUnCom , 2 )
	
	//Verifica preco UN divergente
	If ls_Insert_Update = "U" And ( ldc_vlUn <> ldc_Preco_UN ) Then
		as_mensagem_log = "Existem mais de um registro no XML com valores divergentes no vUnCom ' ( " + String(al_Pedido) + " - " + String( ll_Produto ) + " ) EAN: " + ls_EAN
		Return False	
	End If
	
	If ls_Insert_Update = "I" Then
	
		ldc_pc_desconto = Round( ( at_infnfe.det[ll_Row].prod.vDesc / ( ll_Faturada * ldc_Preco_UN )) * 100 , 2 )
		
		//Se o produto n$$HEX1$$e300$$ENDHEX$$o constar na tb_pbm_produto a qt faturada ser$$HEX1$$e100$$ENDHEX$$ ZERO
		//If Not lb_PBM Then ll_Faturada = 0
				
		Insert Into pedido_central_produto(
				nr_pedido,
				cd_produto,
				qt_estoque_momento,
				qt_pedida,
				qt_recebida,
				vl_preco_unitario,
				pc_desconto,
				id_situacao,
				pc_repasse_icms,
				qt_embalagem_padrao_distrib)
		Values(
			:al_Pedido,
			:ll_Produto,
			0,
			:ll_Faturada,
			0,
			:ldc_Preco_UN,
			:ldc_pc_desconto,
			'C',
			null,
			:ll_qt_embalagem_padrao_distrib)
		Using SqlCa;
	
		If SqlCa.Sqlcode <> 0 Then
			ab_erro = True
			as_mensagem_log = "Erro no insert do item " + String( ll_Produto ) + " . " + SqlCa.SqlErrText
			Return False	
		End If	
	
	Else
				
		//ldc_pc_desconto = Round( ( at_infnfe.det[ll_Row].prod.vDesc / ( ll_Faturada * ldc_Preco_UN )) * 100 , 2 )
		
		ll_Faturada	 = ll_qtPedida + ll_Faturada
		
		//If Not lb_PBM Then ll_Faturada = 0
		
		Update pedido_central_produto
			Set qt_pedida 		= :ll_Faturada
		 Where  nr_pedido 		= :al_Pedido
		 	and   cd_produto 	= :ll_Produto
			Using SqlCa;
		
		If SqlCa.Sqlcode <> 0 Then
			as_mensagem_log = "Erro no update do item " + String( ll_Produto ) + " . " + SqlCa.SqlErrText
			ab_erro = True
			Return False
		End If	
		
	End If

Next

Return True
end function

public function boolean of_verifica_pedido (string as_pedido, ref string as_pedido_sem_caractere);Long ll_Posicao
Long ll_Total
Long ll_Mid = 1

String ls_Caracter

ll_Total = LenA(as_Pedido)

If ll_Total > 0 Then
	
	For ll_Posicao = 1 To ll_Total
		
		ls_Caracter = MidA(as_Pedido, ll_Mid, 1)
		
		ll_Mid++
		
		If Not IsNumber(ls_Caracter) Then
			Continue
		End If
		
		as_Pedido_Sem_Caractere += ls_Caracter
	Next
End If

Return True
end function

private function boolean of_email_comprador (long al_pedido, string as_cnpj_fornecedor, ref string as_email, ref string as_mensagem_log, t_infnfe at_infnfe);String ls_Mensagem_Log

If Not IsNull(al_Pedido) Then	
	select isnull(b.de_endereco_email, '') as de_endereco_email 
	Into :as_Email
	from pedido_central a
	inner join usuario b on b.nr_matricula = a.nr_matricula_cadastramento
	where a.nr_pedido = :al_Pedido
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case -1
			as_Mensagem_Log = "Erro ao localizar o email do comprador'. " + SqlCa.SqlErrText
			Return False
	End Choose

End If

If as_Email = "" Then
	If Not of_Verifica_Email_Comprador(at_infnfe, as_Email, al_Pedido, Ref ls_Mensagem_Log) Then
		Return False
	End If
	
End If

Return True
end function

public function boolean of_valida_produto_pedido (t_infnfe at_infnfe, long al_pedido, ref string as_mensagem_log);Long ll_Qt_Itens, i, ll_Produto, ll_Qtde, ll_Nf, ll_Cod_Produto_Pedido, ll_Achou, ll_Caixa_Padrao

Decimal ldc_Icms, ldc_Icms_St, ldc_Qt_produto

String ls_Tributacao_Icms, ls_Ean, ls_Xprod, ls_Uf_Fornecedor, as_Situacao_Tributaria, ls_multiplicar_dividir

Date ldh_Emissao


SetNull(as_Situacao_Tributaria)

ll_Nf = at_Infnfe.ide.nnf
ll_Qt_Itens = UpperBound(at_InfNFe.det[])

ldh_Emissao			= at_InfNFe.ide.demi
ls_Uf_Fornecedor	= at_InfNFe.emit.endereco.uf
	
For i = 1 to  ll_Qt_Itens
	
	SetNull(ll_Produto)
	
	ll_Produto  = at_Infnfe.det[i].prod.cd_produto_clamed
	ls_Ean 		= Trim(at_Infnfe.det[i].prod.cean)	
	ls_Xprod 	= at_Infnfe.det[i].prod.xprod

	If ls_Ean = "" Then
		ls_Ean = Trim(at_Infnfe.det[i].prod.ceantrib)
	End If
	
	If Not IsNull(al_Pedido) Then
		If Not IsNull(ll_Produto) Then
			select count(*) 
			Into :ll_Qtde
			from pedido_central_produto 
			where nr_pedido	= :al_Pedido
			and cd_produto 	= :ll_Produto
			Using SqlCa;
			
			Choose Case SqlCa.Sqlcode
				Case 0				
					If ll_Qtde = 0 Then
						If Not of_grava_divergencia("Produto n$$HEX1$$e300$$ENDHEX$$o localizado no pedido.", 8, at_Infnfe.det[i].prod.xprod, at_Infnfe.det[i].prod.cEan, Ref as_Mensagem_Log ) Then
							Return False
						End If
					Else					
						
						If Not of_valida_qtde_pedida_nova(at_Infnfe, i, al_Pedido, ll_Produto, Ref as_Mensagem_Log) Then
							Return False	
						End If
						
						ls_Tributacao_Icms 	= at_Infnfe.det[i].imposto.ICMS.TipoICMS
						ldc_Icms 				= at_Infnfe.det[i].imposto.ICMS.vICMS
						ldc_Icms_St 			= at_Infnfe.det[i].imposto.ICMS.pICMSST

						If Not of_Valida_Situacao_Tributaria(al_Pedido, ll_Produto, ls_Xprod, ls_Ean, ldc_Icms, ldc_Icms_St, ls_Tributacao_Icms, ldh_Emissao, ls_Uf_Fornecedor, Ref as_Mensagem_Log, '', 0, as_Situacao_Tributaria) Then
							Return False
						End If					
						
						ldc_Qt_produto = at_Infnfe.det[i].prod.qcom
						
						If Not of_Valida_Quantidade_Fracionada(al_Pedido, ll_Produto, ldc_Qt_produto, Ref as_Mensagem_Log, '', i, ref ll_Caixa_Padrao, ref ls_multiplicar_dividir) Then
							Return False
						End If
							
					End If	
				Case -1
					as_Mensagem_Log = "Verifica se o produto est$$HEX1$$e100$$ENDHEX$$ no pedido'. " + SqlCa.SqlErrText
					Return False
			End Choose
			
		End If
	End If	
	
Next

Return True
end function

public function boolean of_valida_qtde_pedida_nova (t_infnfe at_infnfe, long al_indice, long al_pedido, long al_produto, ref string as_mensagem_log);Long 	ll_Qt_Itens,&
		i,&
		ll_Qt_Pedida,&
		ll_Qt_Recebida
		
String ls_Chave_Nota		
Decimal ldc_Qt_Produto_Calculado, ldc_Qt_Nota


ll_Qt_Itens 		= UpperBound(at_InfNFe.det[])
ls_Chave_Nota 	= Mid(at_InfNFe.id, 4)

ldc_Qt_Nota = at_InfNFe.det[al_Indice].prod.qTrib

For i = 1 to  ll_Qt_Itens
	If Not IsNull(at_InfNFe.det[i].prod.cd_produto_clamed) and Not IsNull(at_InfNFe.det[al_Indice].prod.cd_produto_clamed) Then
		If (at_InfNFe.det[i].prod.cd_produto_clamed = at_InfNFe.det[al_Indice].prod.cd_produto_clamed) And (i <> al_Indice) Then
			ldc_Qt_Nota = ldc_Qt_Nota + at_InfNFe.det[i].prod.qTrib
		End If	
	End If
Next

Select isnull(a.qt_pedida, 0) qt_pedida, 
        isnull(a.qt_recebida, 0) + isnull(c.qt_faturada, 0) qt_recebida 
Into :ll_Qt_Pedida, :ll_Qt_Recebida		  
From pedido_central_produto a 
left outer join nf_compra_pendente b on  b.nr_pedido = a.nr_pedido 
                                             		and b.de_chave_acesso = :ls_Chave_Nota
left outer join nf_compra_pendente_produto c	  on c.cd_filial = b.cd_filial 
															 and c.cd_fornecedor = b.cd_fornecedor 
															 and c.nr_nf         = b.nr_nf 
															 and c.de_especie    = b.de_especie 
															 and c.de_serie      = b.de_serie 
															 and c.cd_produto    = :al_produto
 where a.nr_pedido = :al_pedido
 and a.cd_produto = :al_produto
 Using SqlCa;
 
 Choose Case SqlCa.Sqlcode
	Case 0
		ll_Qt_Recebida = ll_Qt_Recebida + ldc_Qt_Nota
		If ll_Qt_Recebida > ll_Qt_Pedida Then
			If Not of_grava_divergencia("Quantidade pedida "+String(ll_Qt_Pedida)+" $$HEX1$$e900$$ENDHEX$$ diferente da quantidade faturada "+String(ll_Qt_Recebida)+".", 9, at_Infnfe.det[al_Indice].prod.xprod, at_Infnfe.det[al_Indice].prod.cean, Ref as_Mensagem_Log ) Then
				Return False
			End If
		End If
	Case -1
		as_Mensagem_Log = "Erro ao localizar a quantidade pedida'. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_valida_produto_pedido (string as_chave_acesso, long al_pedido, string as_cgc_forn, ref string as_mensagem);Boolean	lb_Nota_Bonificada = False, lb_simples_remessa = False
Date		ldt_Emissao, ldt_dh_recebido_sap
Decimal	ldc_Icms, ldc_Icms_St, ldc_Qt_produto, ldc_Preco_Unitario, ldc_Pc_Desconto, ldc_Icms_deson, ldc_vl_desconto_total, &
			ldc_vl_total_item, ldc_pc_desconto_real
Long		ll_Qt_Itens, ll_for, ll_Produto, ll_Qtde, ll_Nf, ll_Achou, ll_Natureza_Operacao, ll_Embalagem_Padrao, ll_cd_condicao
String	ls_Xprod, ls_Ean, ls_Tributacao_Icms, ls_Pedido_Bonificado, ls_Multiplicar_Dividir, ls_Uf, as_Situacao_Tributaria, &
			ls_de_condicao

dc_uo_ds_base lds


try
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge238_nf_agendamento_item', False) Then
		as_mensagem = "Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW [ds_ge238_nf_agendamento_item]."
		Return False
	End If	
	
	If lds.Retrieve(as_chave_acesso) = -1 Then
		as_mensagem = "Erro ao recuperar os dados da DW [ds_ge238_nf_agendamento_item]."
		Return False
	End If
	
	ll_Qt_Itens = lds.RowCount()
		
	For ll_for = 1 to ll_Qt_Itens
		SetNull(ll_Produto)
	
		ls_Ean						= lds.Object.de_codigo_barras[ll_for]
		ls_Xprod						= lds.Object.de_produto[ll_for]
		ll_Produto					= lds.Object.cd_produto[ll_for]
		ll_Natureza_Operacao		= lds.Object.cd_natureza_operacao[ll_for]
		ldc_Preco_Unitario		= lds.Object.vl_Preco_unitario[ll_for]
		ldc_Pc_Desconto			= lds.Object.pc_desconto[ll_for]
		ldc_vl_desconto_total	= lds.Object.vl_desconto_total[ll_for]
		ldc_vl_total_item			= lds.Object.vl_total_item[ll_for]
		
		if ldc_vl_desconto_total > 0 and ldc_vl_total_item > 0 then
			ldc_pc_desconto_real	= Round((ldc_vl_desconto_total/ldc_vl_total_item) * 100, 6)
		else
			ldc_pc_desconto_real	= ldc_Pc_Desconto
		end if
		
		ldt_Emissao					= Date(lds.Object.dh_emissao[ll_for])
		ls_Uf							= lds.Object.cd_unidade_federacao[ll_for]
		ldt_dh_recebido_sap		= Date(lds.Object.dh_recebido_sap[ll_for])
		
		If Not IsNull(al_Pedido) Then
			If Not IsNull(ll_Produto) and ll_Produto > 0 Then
				select count(*) 
				  Into :ll_Qtde
				  from pedido_central_produto 
				 where nr_pedido	= :al_Pedido
				   and cd_produto = :ll_Produto
				 Using SqlCa;
				
				Choose Case SqlCa.Sqlcode
					Case 0				
						If ll_Qtde = 0 Then
							If Not of_grava_divergencia("Produto n$$HEX1$$e300$$ENDHEX$$o foi localizado no pedido.", 8, ls_Xprod, ls_Ean,&
																Ref as_mensagem, as_chave_acesso, ll_for) Then
								Return False
							End If
						Else					
							If Not of_Valida_Qtde_Pedida_Nova(lds, as_chave_acesso, ll_for, al_Pedido, ll_Produto, Ref as_mensagem) Then Return False	
							
							ls_Tributacao_Icms 		= Mid(lds.Object.cd_cst_tributacao[ll_for], 1, 1)
							ldc_Icms 					= lds.Object.vl_icms[ll_for]
							ldc_Icms_St 				= lds.Object.pc_icms_st[ll_for]
							as_Situacao_Tributaria	= lds.Object.cd_cst_tributacao[ll_for]
							
							If Not of_Valida_Situacao_Tributaria(al_Pedido, ll_Produto, ls_Xprod, ls_Ean, ldc_Icms, ldc_Icms_St, ls_Tributacao_Icms, &
																			 ldt_Emissao, ls_Uf, Ref as_mensagem, as_chave_acesso, ll_for, as_Situacao_Tributaria) Then Return False
							
							ldc_Qt_produto = lds.Object.qt_faturada[ll_for]
							
							If Not of_Valida_Quantidade_Fracionada(al_Pedido, ll_Produto, ldc_Qt_produto, Ref as_mensagem, as_chave_acesso, ll_for, &
																				ref ll_Embalagem_Padrao, ref ls_Multiplicar_Dividir ) Then Return False
							
							if as_Situacao_Tributaria = '40' then
								ldc_Icms_deson	= lds.Object.vl_icms_desonerado[ll_for]
								
								if IsNull(ldc_Icms_deson) then ldc_Icms_deson = 0
								
								if ldc_Icms_deson > 0 then
									ldc_Icms_deson	= ldc_Icms_deson / ldc_Qt_produto
								end if
							else
								ldc_Icms_deson	= 0
							end if
							
							// Se a opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o tiver iniciado no SAP fica do jeito que esta
							If Not ib_Iniciado_Operacao_SAP Then
								select top 1 coalesce(qt_caixa_padrao, 1), 
										 coalesce(id_multiplicar_dividir, 'M')
								  Into :ll_Embalagem_Padrao, 
								  		 :ls_Multiplicar_Dividir
								  from produto_caixa_padrao_forn
								 where cd_fornecedor = (select cd_fornecedor 
								 								  from pedido_central 
																 where nr_pedido = :al_Pedido)
								   and cd_produto 	= :ll_Produto
								 order by dh_alteracao desc
								Using SqlCa;
								
								Choose Case SqlCa.Sqlcode
									Case 100
										ll_Embalagem_Padrao = 1
									Case -1
										as_mensagem = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da embalagem padr$$HEX1$$e300$$ENDHEX$$o do produto'. " + SqlCa.SqlErrText
										Return False
								End Choose
							End If
							
							If Not of_Valida_Preco_Produto(al_Pedido, ll_Produto, ls_Xprod, ls_Ean, ldc_Preco_Unitario, ldc_pc_desconto_real, ldc_Icms_deson, as_chave_acesso, &
																	 ll_Embalagem_Padrao, ls_Multiplicar_Dividir, ll_for, ldt_dh_recebido_sap, Ref as_mensagem) Then Return False
								
						End If	
					Case -1
						as_mensagem = "Verifica se o produto set$$HEX1$$e100$$ENDHEX$$ no pedido'. " + SqlCa.SqlErrText
						Return False
				End Choose		
			End If
			
			If (ll_Natureza_Operacao = 5910) or (ll_Natureza_Operacao = 6910) Then  //Ap$$HEX1$$f300$$ENDHEX$$s a entrada do SAP as naturezas 5949 e 6949 n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o mais consideradas bonificadas.
				lb_Nota_Bonificada = True
			End If
			
			If (ll_Natureza_Operacao = 5949) or (ll_Natureza_Operacao = 6949) Then
				lb_simples_remessa = True
			End If
		End If
	Next
	
	If Not IsNull(al_Pedido) Then
		select coalesce(b.id_bonificada, 'N'),
				 b.cd_condicao,
				 b.de_condicao
		  Into :ls_Pedido_Bonificado,
		  		 :ll_cd_condicao,
				 :ls_de_condicao
		  from pedido_central a 
		 inner join condicao_pagamento b on b.cd_condicao = a.cd_condicao_pagamento 
		 where a.nr_pedido = :al_Pedido
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 100
				as_mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pedido para verificar se $$HEX1$$e900$$ENDHEX$$ bonificado."
				Return False
				
			Case -1
				as_mensagem = "Erro ao verificar se o pedido $$HEX1$$e900$$ENDHEX$$ bonificado: "+SqlCa.SQLErrText
				Return False
		End Choose
		
		If ls_Pedido_Bonificado = "S" and not (lb_Nota_Bonificada or lb_simples_remessa) Then
			If Not of_grava_divergencia("A condi$$HEX2$$e700e300$$ENDHEX$$o do pedido de pagamento (" + String(ll_cd_condicao) + ' - ' + ls_de_condicao + ") est$$HEX1$$e100$$ENDHEX$$ " + &
												 "definida como bonificada, por$$HEX1$$e900$$ENDHEX$$m, a nota fiscal est$$HEX1$$e100$$ENDHEX$$ com uma natureza (" + String(ll_Natureza_Operacao) + ") " + &
												 "que n$$HEX1$$e300$$ENDHEX$$o pertence a Bonificadas (5910 e 6910) ou Simples Remessa (5949 e 6949).", 12, ls_Xprod, ls_Ean,&
												 Ref as_mensagem,  as_chave_acesso, ll_for) Then
				Return False
			End If
		End If
		
		If ls_Pedido_Bonificado <> "S" and lb_Nota_Bonificada Then
			If Not of_grava_divergencia("A nota est$$HEX1$$e100$$ENDHEX$$ com uma natureza (" + String(ll_Natureza_Operacao) + ") definida como bonifica$$HEX2$$e700e300$$ENDHEX$$o, mas, a condi$$HEX2$$e700e300$$ENDHEX$$o de " + &
												 "pagamento (" + String(ll_cd_condicao) + ' - ' + ls_de_condicao + ") n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ bonificada.", 12, ls_Xprod, ls_Ean,&
												 Ref as_mensagem,  as_chave_acesso, ll_for) Then
				Return False
			End If
		End If
	End If
finally
	Destroy lds
end try

Return True
end function

public function boolean of_valida_qtde_pedida_nova (datastore ads, string as_chave_acesso, long al_indice, long al_pedido, long al_produto, ref string as_mensagem_log);Long 	ll_Qt_Itens,&
		i,&
		ll_Qt_Pedida,&
		ll_Qt_Recebida,&
		ll_Qt_Recebida_Importada,&
		ll_Qt_Recebida_Nao_Importada,&
		ll_Caixa_Padrao
		
Decimal ldc_Qt_Produto_Calculado, ldc_Qt_Nota, ldc_Qtde_Nota_Linha

String	ls_Mensagem, ls_multiplicar_dividir, ls_de_chave_acesso_nf_ref, ls_nr_cgc_fornecedor


select de_chave_acesso_nf_ref
  into :ls_de_chave_acesso_nf_ref
  from nf_agendamento_ent a
 where a.de_chave_acesso	= :as_Chave_Acesso
Using SQLCA;

Choose Case SqlCa.Sqlcode
	Case 0
		if not IsNull(ls_de_chave_acesso_nf_ref) and Trim(ls_de_chave_acesso_nf_ref) <> '' Then
			return True
		end if
	Case 100
		as_Mensagem_Log = "Agendamento da nota n$$HEX1$$e300$$ENDHEX$$o foi encontrado"
		Return False
	Case -1
		as_Mensagem_Log = "Erro ao localizar o agendamento. " + SQLCA.SQLErrText
		Return False
End Choose

ll_Qt_Itens			= ads.RowCount()

If Not of_Calcula_Caixa_Padrao(al_pedido, al_Produto,  ads.Object.qt_faturada[al_indice], Ref ldc_Qt_Nota, Ref as_Mensagem_Log, as_chave_acesso, al_indice, ref ll_Caixa_Padrao, ref ls_multiplicar_dividir) Then
	Return False	
End If

For i = 1 to  ll_Qt_Itens
	If Not Isnull(ads.Object.cd_produto[i]) and Not IsNull(ads.Object.cd_produto[al_Indice]) Then
		If (ads.Object.cd_produto[i] = ads.Object.cd_produto[al_Indice]) And (i <> al_Indice) Then
			
			If Not of_Calcula_Caixa_Padrao(al_pedido, al_Produto,  ads.Object.qt_faturada[i], Ref ldc_Qtde_Nota_Linha, Ref as_Mensagem_Log, as_chave_acesso, i, ref ll_Caixa_Padrao, ref ls_multiplicar_dividir) Then
				Return False	
			End If
			
			ldc_Qt_Nota = ldc_Qt_Nota + ldc_Qtde_Nota_Linha
		End If	
	End If
Next

//------------Localiza a quantidade recebida que j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ no agendamento mas ainda n$$HEX1$$e300$$ENDHEX$$o foi importada----------------------------------  
Select coalesce(sum(b.qt_faturada), 0)
Into :ll_Qt_Recebida_Nao_Importada
From nf_agendamento_ent a
Inner Join nf_agendamento_ent_item b on b.de_chave_acesso = a.de_chave_acesso
Where	a.de_chave_acesso	<>	:as_Chave_Acesso
	and a.de_chave_acesso_nf_ref <> :as_Chave_Acesso
	And	a.nr_pedido_central	=		:al_Pedido
	And	not exists				(select * from nf_compra_pendente a1 where a1.de_chave_acesso = a.de_chave_acesso)
	And	not exists				(select * from nf_compra a1 where a1.de_chave_acesso = a.de_chave_acesso)
	And	b.cd_produto			=		:al_Produto
	And	a.dh_cancelamento_agendamento is null
	And	not exists (	Select *
							From nfe_destinadas y	
							Where y.de_chave_acesso in(	Select y1.de_chave_acesso From nf_agendamento_ent y1
																	Where y1.nr_pedido_central = a.nr_pedido_central
																	And y1.de_chave_acesso		<>	:as_Chave_Acesso) 
							And y.id_situacao_nf = '3')

Using SqlCa;	

Choose Case SqlCa.Sqlcode
	Case 0
		
	Case 100
		ll_Qt_Recebida_Nao_Importada = 0
	Case -1
		as_Mensagem_Log = "Erro ao localiza a quantidade recebida que j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ no agendamento mas ainda n$$HEX1$$e300$$ENDHEX$$o foi importada'. " + SqlCa.SqlErrText
		Return False
End Choose

//-----------------------------------------------------------------------------------------------------------------------------------------------------

SELECT
	isnull(pcp.qt_pedida, 0) qt_pedida, 
   (isnull(pcp.qt_recebida, 0) - coalesce(pcp.qt_devolvida, 0)) + isnull(ncpp.qt_faturada, 0) qt_recebida 
INTO
	:ll_Qt_Pedida, 
	:ll_Qt_Recebida_Importada
FROM 
	pedido_central_produto pcp 
INNER JOIN
	pedido_central pc on pc.nr_pedido = pcp.nr_pedido
LEFT JOIN
	nf_compra_pendente ncp on ncp.nr_pedido = pcp.nr_pedido 
                      	 and ncp.de_chave_acesso = :as_chave_acesso
LEFT JOIN
	nf_compra_pendente_produto ncpp on ncpp.cd_filial 		= ncp.cd_filial 
											 and ncpp.cd_fornecedor = ncp.cd_fornecedor 
											 and ncpp.nr_nf         = ncp.nr_nf 
											 and ncpp.de_especie    = ncp.de_especie 
											 and ncpp.de_serie      = ncp.de_serie 
											 and ncpp.cd_produto    = :al_produto
 WHERE
 	pcp.nr_pedido 	= :al_pedido AND
	pcp.cd_produto = :al_produto AND
	pc.id_situacao	<> 'X'
USING SQLCA;
 
 Choose Case SqlCa.Sqlcode
	Case 0
		ll_Qt_Recebida = ll_Qt_Recebida_Importada + ldc_Qt_Nota + ll_Qt_Recebida_Nao_Importada
		If ll_Qt_Recebida > ll_Qt_Pedida Then
			ls_Mensagem	= "Quantidade faturada "+String(ll_Qt_Recebida) + " maior do que a quantidade pedida "+ String(ll_Qt_Pedida)+". "
			
			If (ll_Qt_Recebida_Importada + ll_Qt_Recebida_Nao_Importada) > 0 Then
				ls_Mensagem += "Qtde. dessa nota: "+String(ldc_Qt_Nota)+". Qtde. j$$HEX1$$e100$$ENDHEX$$ recebida em outras notas: "+String(ll_Qt_Recebida_Importada + ll_Qt_Recebida_Nao_Importada)
			End If
			
			If Not of_grava_divergencia(ls_Mensagem, 9, ads.Object.de_produto[al_Indice], &
												ads.Object.de_codigo_barras[al_Indice], Ref as_Mensagem_Log, as_chave_acesso, al_indice ) Then
				Return False
			End If
		End If
	Case -1
		as_Mensagem_Log = "Erro ao localizar a quantidade pedida'. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_verifica_email_comprador (t_infnfe at_infnfe, ref string as_email, long al_pedido, ref string as_mensagem_log);Boolean lb_Sucesso = False

Long ll_Produto
Long ll_Cod_Produto_Pedido
Long ll_Pedido
Long ll_Linha
Long ll_Tamanho
Long ll_Qt_Itens
Long ll_Cont
Long ll_Qt_Array

String ls_Email
String ls_Ean
String ls_Ean_Trib
String ls_Cgc_Fornecedor
String ls_Xprod
String ls_Produto_Distribuidora

Decimal	ldc_Qt_Produtos

//Se tem pedido, procura o e-mail do comprador
If Not IsNull(al_Pedido) Then
	select isnull(b.de_endereco_email, '') as de_endereco_email 
		Into :as_Email
	from pedido_central a
		inner join usuario b
			on b.nr_matricula = a.nr_matricula_cadastramento
	where a.nr_pedido = :al_Pedido
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case 0
			//Monta a estrutura com email do comprador
			If ib_Grava_Agendamento Then
				str.ps_to[1] = as_Email
			End If
					
			Return True
			
		Case -1
			as_Mensagem_Log = "Erro ao localizar o email do comprador. Pedido '" + String(al_Pedido) + "'. " + SqlCa.SqlErrText
			Return False
	End Choose
	
Else
	
	//Sen$$HEX1$$e300$$ENDHEX$$o procura um produto do XML
	ll_Qt_Itens = UpperBound(at_InfNFe.det[])
	
	If ll_Qt_Itens > 0 Then
		
		For ll_Cont = 1 To ll_Qt_Itens
	
			ll_Cod_Produto_Pedido	= at_infnfe.det[ll_Cont].prod.nitemped
			ls_Produto_Distribuidora 	= at_Infnfe.det[ll_Cont].prod.cprod
			ls_Ean						= trim(at_Infnfe.det[ll_Cont].prod.cean)
			ls_Ean_Trib					= trim(at_Infnfe.det[ll_Cont].prod.ceantrib)
			ls_Cgc_Fornecedor		= at_Infnfe.emit.cnpj
			ls_Xprod						= at_Infnfe.det[ll_Cont].prod.xprod
			ldc_Qt_Produtos			= at_Infnfe.det[ll_Cont].prod.qcom
			
			If Not of_Valida_Produto_Xml(ll_Cod_Produto_Pedido, ls_Produto_Distribuidora, ls_Ean, ls_Ean_Trib, ls_Cgc_Fornecedor, ls_Xprod, ldc_Qt_Produtos, Ref as_Mensagem_Log, '', 0, Ref ll_Produto, False) Then
				Return False
			End If
			
			If ll_Produto = 0 Then
				Continue
			End If
			
			Select top 1 c.nr_pedido,  u.de_endereco_email
				Into :ll_Pedido, :as_Email
			From pedido_central As c
				Inner Join pedido_central_produto As p
					On p.nr_pedido = c.nr_pedido
				Left Outer Join usuario As u
					On u.nr_matricula = c.nr_matricula_cadastramento
			Where p.cd_produto = :ll_Produto
				And c.id_situacao <> 'X'
				And c.dh_pedido > dateadd(month,-6,getdate())
			Order By c.nr_pedido Desc
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					If ll_Pedido > 0 Then
						lb_Sucesso = True
						Exit
					End If
						
				Case 100
													
				Case -1
					as_Mensagem_Log = "Erro ao consultar o produto no pedido. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_email_comprador. " + SqlCa.SqlErrText
					Return False
			End Choose	
		Next
		
		If lb_Sucesso Then
			
			//Se achou um produto v$$HEX1$$e100$$ENDHEX$$lido e que foi pedido nos $$HEX1$$fa00$$ENDHEX$$ltimos 6 meses, captura o e-mail do comprador que fez este $$HEX1$$fa00$$ENDHEX$$ltimo pedido
			Select u.de_endereco_email
				Into :as_Email
			From pedido_central as c
				Inner Join usuario as u
					On u.nr_matricula = c.nr_matricula_cadastramento
			Where c.nr_pedido = :ll_Pedido
			Using SqlCa;
			
			Choose Case SqlCa.Sqlcode
				Case 0
					
					//Monta a estrutura com email do comprador
					If ib_Grava_Agendamento Then
						str.ps_to[1] = as_Email
					End If
					
					Return True
					
				Case 100
					as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o e-mail do comprador no pedido '" + String(ll_Pedido) + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_verifica_email_comprador."
					Return False
													
				Case -1
					as_Mensagem_Log = "Erro ao localizar o email do comprador no pedido. Fun$$HEX2$$e700e300$$ENDHEX$$o of_verifica_email_comprador. " + SqlCa.SqlErrText
					Return False
			End Choose
		End If
		
		//Se n$$HEX1$$e300$$ENDHEX$$o localizou nenhum pedido para os produtos do XML, envia e-mail para todos os coordenadores do Compras	
		dc_uo_ds_base lds_Email
		lds_Email = Create dc_uo_ds_base
		
		If Not lb_Sucesso Then
			If Not lds_Email.of_ChangeDataObject("ds_ge238_email_coordenador") Then
				as_Mensagem_Log = "Erro ao carregar o data store 'ds_ge238_email_coordenador'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_verifica_email_comprador. " + SqlCa.SqlErrText
				Destroy(lds_Email)
				Return False
			End If
			
			If lds_Email.Retrieve() > 0 Then
				For ll_Linha = 1 To lds_Email.RowCount()
					as_Email += lds_Email.Object.De_Email[ll_Linha] + ";"
				Next
				
				//Remove o ponto e v$$HEX1$$ed00$$ENDHEX$$rgula do final da string
				ll_Tamanho = LenA(as_Email)
				as_Email = MidA(as_Email, 1, ll_Tamanho -1)
				
				If ib_Grava_Agendamento Then
					//Inicializa o contador
					ll_Linha = 0
					//Monta a estrutura de e-mail com os coordenadores
					For ll_Linha = 1 To lds_Email.RowCount()
						str.ps_to[ll_Linha] = lds_Email.Object.De_Email[ll_Linha]
					Next
				End If
			End If
			
			Destroy(lds_Email)
		End If
	End If
End If

Return True
end function

public function boolean of_grava_historico_divergencia_agend (string as_chave_acesso, long al_tipo_divergencia, string as_de_divergencia, dc_uo_transacao a_sqlca, ref string as_mensagem_log);DateTime ldh_Data_Atual

Long ll_Achou

Select Count(*)
 Into :ll_Achou
From nf_agendamento_ent_diverg_hist
Where de_chave_acesso = :as_Chave_Acesso
	And cd_tipo_divergencia = :al_Tipo_Divergencia
Using a_SqlCa;

If a_SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao consultar o hist$$HEX1$$f300$$ENDHEX$$rico de diverg$$HEX1$$ea00$$ENDHEX$$ncias de agendamento chave '" + as_Chave_Acesso + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_historico_divergencia_agend" + a_SqlCa.SqlErrText
	Return False
End If

If ll_Achou > 0 Then
	Return True
Else
	
	ldh_Data_Atual = gf_GetServerDate()
	
	Insert Into nf_agendamento_ent_diverg_hist(de_chave_acesso, cd_tipo_divergencia, de_divergencia, dh_registro)
		Values(:as_Chave_Acesso, :al_Tipo_Divergencia, :as_De_Divergencia, :ldh_Data_Atual)
	Using a_SqlCa;
	
	If a_SqlCa.SqlCode = -1 Then
		a_SqlCa.of_RollBack();
		as_Mensagem_Log = "Erro ao gravar o hist$$HEX1$$f300$$ENDHEX$$rico de diverg$$HEX1$$ea00$$ENDHEX$$ncia de agendamento chave '" + as_Chave_Acesso + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_historico_divergencia_agend" + a_SqlCa.SqlErrText
		Return False
	End If
End If
end function

public function boolean of_valida_cnpj_fornecedor_cadastrado (string as_cgc_fornecedor, ref string as_mensagem_log, string as_chave_acesso);Integer li_Achou

select count(*)
Into :li_Achou
from fornecedor
where nr_cgc = :as_cgc_fornecedor
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	as_Mensagem_Log = "Localizar o CNPJ do fornecedor do XML. " + SqlCa.SqlErrText
	Return False
Else
	If li_Achou = 0 Then
		If Not of_grava_divergencia("N$$HEX1$$e300$$ENDHEX$$o existe fornecedor cadastrado para o CNPJ informado na nota ("+as_cgc_fornecedor+")", 2, "", "", Ref as_Mensagem_Log, as_chave_acesso, 0 ) Then
			Return False
		End If
	End If
End If

Return True

//Choose Case SqlCa.Sqlcode
//	Case 0
//		If ls_Situacao = 'I' Then
//			If Not of_grava_divergencia("O fornecedor da nota ("+as_cgc_fornecedor+") esta INATIVO.", 2, "", "", Ref as_Mensagem_Log, as_chave_acesso, 0 ) Then
//				Return False
//			End If
//		End If
//	Case 100
//		If Not of_grava_divergencia("N$$HEX1$$e300$$ENDHEX$$o existe fornecedor cadastrado para o CNPJ informado na nota ("+as_cgc_fornecedor+")", 2, "", "", Ref as_Mensagem_Log, as_chave_acesso, 0 ) Then
//			Return False
//		End If
//	Case -1
//		as_Mensagem_Log = "Localizar o CNPJ do fornecedor do XML. " + SqlCa.SqlErrText
//		Return False
//End Choose
//
//Return True
end function

public function boolean of_atualiza_finalidade_nfe (string as_finnfe, string as_chave, ref string as_mensagem);Boolean lb_Sucesso = True

Update nfe_indexacao
    set id_finnfe = :as_finnfe
Where id_nf = :as_chave
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem = "Tab_nfe_indexacao - Erro no update da finalidadade NFe. "+ SqlCa.SqlErrText
	SqlCa.of_Rollback()
	Return False
End If

Update nfe_destinadas
    set id_finnfe = :as_finnfe
Where de_chave_acesso = :as_chave
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem = "Tab_nfe_destinadas - Erro no update da finalidadade NFe. "+ SqlCa.SqlErrText
	SqlCa.of_Rollback()
	Return False
End If

of_executa_commit()

Return lb_Sucesso
end function

public function boolean of_valida_historico_embalagem_padrao (long al_pedido, long al_produto, string as_de_produto, string as_ean, string as_chave_acesso, long al_indice, ref string as_mensagem);Long	ll_Caixa_Padrao_Historico,&
		ll_Caixa_Padrao
			
String	ls_Mensagem,&
		ls_Fornecedor,&
		ls_Distribuidora

//Seleciona o fornecedor do pedido
Select	a.cd_fornecedor,
		coalesce(b.id_distribuidora, 'N')
Into	:ls_Fornecedor,
		:ls_Distribuidora
From pedido_central a
Inner Join fornecedor b on b.cd_fornecedor = a.cd_fornecedor
where nr_pedido = :al_Pedido
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		//Somente para Fabricantes
		If ls_Distribuidora = "S" Then
			Return True
		End If
	Case 100
		as_mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o fornecedor do pedido "+String(al_Pedido)+". Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_historico_embalagem_padrao'."
		Return False
	Case -1
		as_mensagem = "Localiza o fornecedor do pedido'. " + SqlCa.SqlErrText
		Return False
End Choose

//Localiza a embalagem padr$$HEX1$$e300$$ENDHEX$$o do hist$$HEX1$$f300$$ENDHEX$$rico
Select top 1 qt_caixa_padrao
Into	:ll_Caixa_Padrao_Historico
From produto_caixa_padrao_forn 
Where	cd_fornecedor	= :ls_Fornecedor
	And	cd_produto		= :al_Produto
Order by dh_alteracao desc
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100
		//Se n$$HEX1$$e300$$ENDHEX$$o tiver hist$$HEX1$$f300$$ENDHEX$$rico de embalagem padr$$HEX1$$e300$$ENDHEX$$o retorna true, n$$HEX1$$e300$$ENDHEX$$o compara.
		Return True
	Case -1
		as_mensagem = "Localiza a embalagem padr$$HEX1$$e300$$ENDHEX$$o do hist$$HEX1$$f300$$ENDHEX$$rico'. " + SqlCa.SqlErrText
		Return False
End Choose

//Localiza a embalagem padr$$HEX1$$e300$$ENDHEX$$o do produto
select nr_embalagem_padrao
Into	:ll_Caixa_Padrao
from produto_geral
where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100
		as_mensagem = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a embalagem padr$$HEX1$$e300$$ENDHEX$$o do produto "+String(al_Produto)+". Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_historico_embalagem_padrao'."
		Return False
	Case -1
		as_mensagem = "Localiza a embalagem padr$$HEX1$$e300$$ENDHEX$$o do produto'. " + SqlCa.SqlErrText
		Return False
End Choose


If ll_Caixa_Padrao_Historico <> ll_Caixa_Padrao Then
	ls_Mensagem	= "Embalagem padr$$HEX1$$e300$$ENDHEX$$o ("+String(ll_Caixa_Padrao_Historico)+") do hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es est$$HEX1$$e100$$ENDHEX$$ diferente da embalagem padr$$HEX1$$e300$$ENDHEX$$o ("+String(ll_Caixa_Padrao)+") do cadastro do produto."
	If Not of_grava_divergencia(ls_Mensagem, 13, as_De_Produto, as_Ean, Ref as_Mensagem, as_chave_acesso, al_indice ) Then
		Return False
	End If
End If

Return True
end function

public function boolean of_valida_produto_xml (long al_nitemped, string as_cprod, string as_ean, string as_ean_trib, string as_cnpj_emit, string as_xprod, decimal adc_qtde, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_nf, ref long al_produto, boolean ab_grava_divergencia);Long		ll_Achou, ll_Produto_Xml
String 	ls_Ean

If adc_Qtde = 0 Then
	If Not of_grava_divergencia("Produto est$$HEX1$$e100$$ENDHEX$$ com a quantidade zerada.", 1, as_xprod, "", Ref as_Mensagem_Log, as_chave_acesso, ai_item_nf  ) Then
		Return False
	End If
End If

If as_ean = "SEM GTIN" Then
	as_ean = ""
End If

If as_ean_trib = "SEM GTIN" Then
	as_ean_trib = ""
End If

If as_ean <> "" or as_ean_trib <> "" Then
	//<cEANTrib> Valida o EAN do Produto
	If as_ean_trib <> "" Then
		ls_Ean = "%"+gf_Tira_Zero_Esquerda(as_ean_trib)
			
		select top 1 cd_produto 
		  into :al_produto
		  from codigo_barras_produto 
		 where de_codigo_barras like :ls_Ean
		 using SqlCa;

		Choose Case SqlCa.Sqlcode
			Case 0
				Return True
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela 'codigo_barras_produto', <cEANTrib>. EAN: " + ls_Ean + " - " + SqlCa.SqlErrText
				Return False
		End Choose
	End If
	
	//<cEAN> Valida o EAN (DUN) da embalagem
	If as_ean <> "" Then
		ls_Ean = "%"+gf_Tira_Zero_Esquerda(as_ean)

		select top 1 cd_produto 
		  into :al_produto
		  from codigo_barras_produto 
		 where de_codigo_barras like :ls_Ean
		 using SQLCA;
		
		Choose Case SqlCa.Sqlcode
			Case 0
				Return True
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela 'codigo_barras_produto', <cEAN>. EAN: " + ls_Ean + " - " + SqlCa.SqlErrText
				Return False
		End Choose
	End If
	
	//Localiza o nosso produto pelo c$$HEX1$$f300$$ENDHEX$$digo de produto do fornecedor <cProd>
	If Not IsNull(as_CProd) And as_CProd <> "" Then
		select top 1 cd_produto
		  Into :al_produto
		  from distribuidora_produto
		  where cd_distribuidora  in (select cd_fornecedor from fornecedor where nr_cgc = :as_cnpj_emit and id_distribuidora = 'S')
		    and cd_produto_distribuidora = :as_CProd
		  Using SQLCA;
		
		Choose Case SqlCa.Sqlcode
			Case 0
				Return True
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela 'distribuidora_produto'. EAN: " + ls_Ean + " - " + SqlCa.SqlErrText
				Return False
		End Choose
	End If
Else
	
	// Verifica se o CNPJ emissor $$HEX1$$e900$$ENDHEX$$ um fornecedor ou uma filial
   Select Count(*)  
     into :ll_Achou
     from fornecedor fo
    where fo.nr_cgc not in (select fi.nr_cgc 
	 							      from filial fi) 
    	and fo.nr_cgc = :as_cnpj_emit
    using SQLCA;

  	Choose Case SqlCa.Sqlcode
   	Case 0
			//Se for um fornecedor ou distribuidora deve buscar pelo c$$HEX1$$f300$$ENDHEX$$digo de distribuidora produto
			If Not IsNull(as_CProd) And as_CProd <> "" Then
				select top 1 cd_produto
				  Into :al_produto
				  from distribuidora_produto
				 where cd_distribuidora  in (select cd_fornecedor 
				 										 from fornecedor 
														where nr_cgc = :as_cnpj_emit 
														  and id_distribuidora = 'S')
				   and cd_produto_distribuidora = :as_CProd
				 Using SqlCa;
				
				Choose Case SqlCa.Sqlcode
					Case 0
						Return True
					Case -1
						as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela 'distribuidora_produto'. EAN: " + ls_Ean + " - " + SqlCa.SqlErrText
						Return False
				End Choose			
			End If
      Case 100
			//Se for de uma filial deve buscar direto no c$$HEX1$$f300$$ENDHEX$$digo do produto
			If Not IsNull(as_CProd) And as_CProd <> "" Then
				ll_Produto_Xml = Long(as_CProd)
					
				select cd_produto
				  into :al_Produto
				  from produto_geral
				 where cd_produto = :ll_Produto_Xml
				 using SqlCa;
				
				Choose Case SqlCa.SqlCode					
					Case 0
						Return True
					Case -1
						as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela 'produto_geral', <cProd>. C$$HEX1$$f300$$ENDHEX$$digo: " + String(as_CProd) + " - " + SqlCa.SqlErrText
						Return False
				End Choose
			End If
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o Fornecedor: 'fornecedor'. CNPJ: " + as_cnpj_emit + " - " + SqlCa.SqlErrText
			Return False
	End Choose
	
	// <nitemped>
	If Not IsNull(al_nitemped) and al_nitemped > 0 Then
		select cd_produto
		  into :al_produto
		  from produto_geral
		  where cd_produto =:al_nitemped
		  and id_situacao = 'A'
		  using SQLCA;
		
		Choose Case SqlCa.SqlCode
			Case 0
				Return True
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela 'produto_geral', <nitemped>. C$$HEX1$$f300$$ENDHEX$$digo: " + String(al_nitemped) + " - " + SqlCa.SqlErrText
				Return False
		End Choose
	End If
	
End If

If ab_Grava_Divergencia and Not ib_Iniciado_Operacao_SAP Then
	
	If (as_ean = "") and (as_ean_trib = "") and ((Not IsNull(as_CProd) And as_CProd <> "")  or ( Not IsNull(al_nitemped) and al_nitemped > 0)) Then
		If Not of_grava_divergencia("Produto est$$HEX1$$e100$$ENDHEX$$ sem o c$$HEX1$$f300$$ENDHEX$$digo de barras (EAN) no arquivo XML. Tag (cEAN) e (cEANTrib).", 7, as_xprod, "", Ref as_Mensagem_Log, as_chave_acesso, ai_item_nf  ) Then
			Return False
		End If
		Return True
	End If
	
	If (as_ean <> "") or (as_ean_trib <> "") Then
		If as_ean = "" Then
			as_ean = as_ean_trib
		End If
		
		If Not of_grava_divergencia("Nenhum produto foi localizado em nossa base de dados com o c$$HEX1$$f300$$ENDHEX$$digo de barras (EAN) informado no XML.", 6, as_xprod, as_ean, Ref as_Mensagem_Log, as_chave_acesso, ai_item_nf  ) Then
			Return False
		End If
		
		Return True
	End If
		
	If Not of_grava_divergencia("Produto est$$HEX1$$e100$$ENDHEX$$ sem o c$$HEX1$$f300$$ENDHEX$$digo de barras (EAN) no arquivo XML. Tag (cEAN) e (cEANTrib).", 7, as_xprod, "", Ref as_Mensagem_Log, as_chave_acesso, ai_item_nf ) Then
		Return False
	End If
	
End If
	
Return True
end function

public function boolean of_envia_email_agendamento (string as_mensagem, string as_cnpj_forn, string as_de, ref string as_log, integer ai_log, boolean ab_envia_email_fornecedor);Long ll_Linha

String ls_Null[]
String ls_Msg_Email_Erro = ""

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If ab_Envia_Email_Fornecedor Then
	If Not ib_Diverg_Ped_Trocado Then			
		If Not lds.of_ChangeDataObject("ds_ge238_email_fornecedor_agendamento") Then
			as_Log = "Erro ao carregar o data store ds_ge238_email_fornecedor_agendamento"
			Return False
		End If
		
		If lds.Retrieve(ivs_Chave_Acesso) < 0 Then
			as_Log = "Erro no retrieve do data store ds_ge238_email_fornecedor_agendamento"
			Return False
		End If
		
		//Se n$$HEX1$$e300$$ENDHEX$$o localizou nenhum e-mail, utiliza os contatos do tipo Comercial
		If lds.RowCount() = 0 Then
			If Not lds.of_ChangeDataObject("ds_ge238_email_comercial_forn") Then
				as_Log = "Erro ao carregar o data store ds_ge238_email_comercial_forn"
				Return False
			End If
			
			If lds.Retrieve(as_CNPJ_Forn) < 0 Then
				as_Log = "Erro no retrieve do data store ds_ge238_email_comercial_forn"
				Return False
			End If
		End If
		
	Else
		//il_Tipo_Divergencia 2 $$HEX1$$e900$$ENDHEX$$ quando um fornecedor fatura um pedido de outro fornecedor
		//Ex: O CNPJ DO EMISSOR DA NOTA (89054050000408) $$HEX1$$c900$$ENDHEX$$ DIFERENTE DO FORNECEDOR DO PEDIDO (82873068000140)
		
		If Not lds.of_ChangeDataObject("ds_ge238_email_comercial_forn") Then
			as_Log = "Erro ao carregar o data store ds_ge238_email_comercial_forn"
			Return False
		End If
		
		If lds.Retrieve(as_CNPJ_Forn) < 0 Then
			as_Log = "Erro no retrieve do data store ds_ge238_email_comercial_forn"
			Return False
		End If
	End If
	
	For ll_Linha = 1 To lds.RowCount()
		str.ps_cc[ll_Linha] = Lower(lds.Object.De_Email[ll_Linha])
	Next

	Destroy(lds)
End If

If ib_Envia_Email_Fiscal Then
	str.ps_cc[ UpperBound(str.ps_cc[]) + 1 ] = "fiscal@clamed.com.br"
	str.ps_cc[ UpperBound(str.ps_cc[]) + 1 ] = "lais.neumann@clamed.com.br"
End If

str.ps_Mensagem = as_mensagem
str.pb_assinatura = True

// Desenvolvimento
If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

//Se n$$HEX1$$e300$$ENDHEX$$o conseguir enviar e-mail com c$$HEX1$$f300$$ENDHEX$$pia para os fornecedores, envia e-mail para os compradores com o corpo do e-mail original
If Not gf_ge202_envia_email_padrao(85, str) Then
	
	ll_Linha = 0
	
	//TO
	If UpperBound(str.ps_to) > 0 Then ls_Msg_Email_Erro += '<br>PARA: <i>'
	For ll_Linha = 1 to UpperBound(str.ps_to)
		If ll_Linha > 1 Then ls_Msg_Email_Erro += ', '
		ls_Msg_Email_Erro += str.ps_to[ll_Linha]
	Next
	
	If UpperBound(str.ps_to) > 0 Then ls_Msg_Email_Erro += '</i>'
	//CC
	If UpperBound(str.ps_cc) > 0 Then ls_Msg_Email_Erro += '<br>C$$HEX1$$d300$$ENDHEX$$PIA: <i>'
	For ll_Linha = 1 to UpperBound(str.ps_cc)
		If ll_Linha > 1 Then ls_Msg_Email_Erro += ', '
		ls_Msg_Email_Erro += str.ps_cc[ll_Linha]
	Next
	
	If UpperBound(str.ps_cc) > 0 Then ls_Msg_Email_Erro += '</i>'
	//CCO
	If UpperBound(str.ps_co) > 0 Then ls_Msg_Email_Erro += '<br>C$$HEX1$$d300$$ENDHEX$$PIA OCULTA: <i>'
	For ll_Linha = 1 to UpperBound(str.ps_co)
		If ll_Linha > 1 Then ls_Msg_Email_Erro += ', '
		ls_Msg_Email_Erro += str.ps_co[ll_Linha]
	Next
	
	If UpperBound(str.ps_co) > 0 Then ls_Msg_Email_Erro += '</i>'
	//MSG
	
	ls_Msg_Email_Erro += '<br><br>MENSAGEM ORIGINAL: <i>'+str.ps_mensagem+'</i>'

	//Limpa o str.ps_cc[] que cont$$HEX1$$e900$$ENDHEX$$m o contato dos fornecedores
	str.ps_cc[] = ls_Null[]
	str.ps_mensagem = ""
	
	str.ps_mensagem = 'Caro(a) Comprador(a), ~r~n~r~n'+ &
							   'Ocorreu um erro na tentativa do sistema GN enviar o email [GN] - Diverg$$HEX1$$ea00$$ENDHEX$$ncias Agendamento (cod. '+String(85)+').~r~n~r~n' + &
							    ls_Msg_Email_Erro						

	gf_ge202_envia_email_padrao(86, str)
End If

Return True
end function

public function boolean of_envia_email_divergencias_dll (long al_pedido, t_infnfe at_infnfe, string as_diretorio_xml, ref string as_mensagem_log, integer ai_log, boolean ab_envia_email_fornecedor);Long	ll_Nr_Nf,&
		ll_Linha,&
		ll_Linhas
		
String		ls_Chave_Nota,&
			ls_Especie,&
			ls_Serie,&
			ls_Divergencias,&
			ls_Texto_Email,&
			ls_Cnpj_Fornecedor,&
			ls_Email,&
			ls_Nm_Fornecedor,&
			ls_Pedido = "",&
			ls_destinatarios,&
			ls_Anexo,&
			ls_Email_Copia,&
			ls_Nat_Operacao, &
			ls_Texto_Agend, &
			ls_Anexo_Email[], &
			ls_Msg_Historico
			
Decimal ldc_Valor_Nf

ls_Cnpj_Fornecedor	= at_Infnfe.emit.cnpj
ls_Chave_Nota 			= ivs_Chave_Acesso
ls_Nm_Fornecedor		= at_Infnfe.emit.xnome
ll_Nr_Nf 					= at_Infnfe.ide.nnf
ldc_Valor_Nf			= at_Infnfe.total.icmstot.vnf
ls_Nat_Operacao		= at_Infnfe.ide.natop

// Chamado 1572234: Retirar Envio Email // Desativado a Mensagem 85 e 86 tamb$$HEX1$$e900$$ENDHEX$$m.
Return True


//If Not of_email_comprador(al_Pedido, ls_Cnpj_Fornecedor, Ref ls_Email, Ref as_mensagem_log, at_infnfe) Then
//	Return False
//End If

If Not of_Verifica_Email_Comprador(at_infnfe, Ref ls_Email, al_Pedido, Ref as_mensagem_log) Then
	Return False
End If

If gvo_Aplicacao.ivs_DataSource = 'central' Then
	If Not ib_Grava_Agendamento Then	
		ls_Email_Copia = "cleser.wiggers@clamed.com.br; sergio.gol@clamed.com.br; anderson.lima@clamed.com.br"
		
		ls_destinatarios = "heder@clamed.com.br"
		
		If (ls_Email <> "") and (ls_Email <> "heder@clamed.com.br") Then
			ls_destinatarios = ls_destinatarios +"; "+ls_Email
		End If
	End If
End If

ls_Chave_Nota 		= ivs_Chave_Acesso
ls_Especie			= "NFE"
ls_Serie				= at_Infnfe.ide.serie

ll_Linhas = UpperBound(ivs_Divergencias[])

For ll_Linha = 1 to ll_Linhas
	ls_Divergencias = ls_Divergencias + "~r"+ ivs_Divergencias[ll_Linha]+"~r"
Next

If Not IsNull(al_Pedido) Then
	ls_Pedido = 	String(al_Pedido)
End If

ls_Texto_Email =	"FORNECEDOR: "+ls_Nm_Fornecedor+"~r"+&
						"NOTA: "+String(ll_Nr_Nf)+"~r"+&
						"VALOR: "+String(ldc_Valor_Nf, "###,###.00")+"~r"+&
						"NAT. OPERA$$HEX2$$c700c300$$ENDHEX$$O: "+ls_Nat_Operacao+"~r"+&
						"PEDIDO: "+ls_Pedido+"~r"+&
						"CHAVE DE ACESSO: "+ls_Chave_Nota+"~r"+&
						ls_Divergencias

Try
	dc_uo_eventos_sefaz lo_Eventos_Sefaz
	lo_Eventos_Sefaz = create dc_uo_eventos_sefaz

	If Not ib_Grava_Agendamento Then
		
		If Not lo_Eventos_Sefaz.of_envia_xml_por_email(ls_Chave_Nota, ls_destinatarios, ls_Email_Copia, ls_Texto_Email, "Diverg$$HEX1$$ea00$$ENDHEX$$ncias Notas", as_Diretorio_Xml, Ref as_Mensagem_Log) Then
			Return False
		End If
	Else
		
		//Email agendamento, $$HEX1$$e900$$ENDHEX$$ enviado sem chave de acesso
		If IsNull (ls_Chave_Nota) then
			ls_Chave_Nota = ''
		End if
		ls_Texto_Email =	"FORNECEDOR: "+ls_Nm_Fornecedor+"<br>" + & 
								"NOTA: "+String(ll_Nr_Nf)+"<br>" + &
								"VALOR: "+String(ldc_Valor_Nf, "###,###.00")+"<br>" + &
								"NAT. OPERA$$HEX2$$c700c300$$ENDHEX$$O: "+ls_Nat_Operacao+"<br>" + &
								"PEDIDO: " + ls_Pedido + "<br>" + &
								"CHAVE DE ACESSO: " + ls_Chave_Nota + "<br><br>"+&
								ls_Divergencias

//		If Not gf_grava_historico_alteracao_tabela("DIVERGENCIA_AGEND", "of_envia_email_divergencias_dll", "", ls_Nm_Fornecedor + "||" + String(ll_Nr_Nf), "", "215117", "A", Ref ls_Msg_Historico, False) Then
//			as_mensagem_log = "Erro ao gravar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_email_divergencias_dll"
//			Return False
//		End If		
	
		ls_Texto_Agend = "E-mail autom$$HEX1$$e100$$ENDHEX$$tico enviado pela CIA LATINO AMERICANA DE MEDICAMENTOS (CLAMED)<br><br>" + &
								"Motivo: Diverg$$HEX1$$ea00$$ENDHEX$$ncias na valida$$HEX2$$e700e300$$ENDHEX$$o do XML<br><br>"

		ls_Texto_Agend = ls_Texto_Agend + 	ls_Texto_Email
				
		If Not of_Envia_Email_Agendamento(ls_Texto_Agend, ls_Cnpj_Fornecedor, ls_Nm_Fornecedor + "||" + String(ll_Nr_Nf), Ref as_mensagem_log, ai_Log, ab_Envia_Email_Fornecedor) Then
			Return False
		End If
		
	End If //Fim agendamento
	
Finally
	Destroy(lo_Eventos_Sefaz)
End Try

Return True
end function

public function boolean of_valida_data_emissao_pedido (long al_pedido, date adt_emissao_nf, ref string as_retorno);Date	ldt_Pedido,&
		ldt_Pedido_Aux

Long	ll_Qtde_Almox

Select		cast(dh_pedido as date),
			(select count(*) from pedido_central_produto a
			inner join produto_geral b on b.cd_produto = a.cd_produto
			where a.nr_pedido = :al_Pedido 
			and substring(b.cd_subcategoria, 1, 1) = '5')
Into	:ldt_Pedido,
		:ll_Qtde_Almox
From pedido_central
Where nr_pedido = :al_Pedido
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		if not ib_Iniciado_Operacao_SAP then
			If ll_Qtde_Almox	> 0 Then
				ldt_Pedido_Aux = RelativeDate(ldt_Pedido, 60)
				
				If adt_Emissao_Nf > ldt_Pedido_Aux	Then
					as_Retorno	= "O FORNECEDOR FATUROU O PEDIDO QUE FOI EMITIDO A MAIS DE 60 DIAS"
					Return False
				End If
			Else
				ldt_Pedido_Aux = RelativeDate(ldt_Pedido, 30)
				
				If adt_Emissao_Nf > ldt_Pedido_Aux	Then
					as_Retorno	= "O FORNECEDOR FATUROU O PEDIDO QUE FOI EMITIDO A MAIS DE 30 DIAS"
					Return False
				End If
			End If
		end if		
	Case 100
		as_Retorno = "N$$HEX1$$e300$$ENDHEX$$o localizado o pedido de n$$HEX1$$fa00$$ENDHEX$$mero "+String(al_Pedido)+"."
		Return False
		
	Case -1
		as_Retorno = "Erro ao verificar se $$HEX1$$e900$$ENDHEX$$ para desconsiderar a meta de compra do pedido: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_verifica_divergencias_agendamento (string as_chave_acesso, date adh_emissao_nf, ref string as_mensagem);Long	ll_Pedido,&
		ll_Qtde,&
		ll_Volumes

String	ls_CGC_Forn,&
		ls_Distribuidora

Select		nr_pedido_central,
			nr_cgc_fornecedor,
			coalesce(qt_volumes, 0)
Into	:ll_Pedido,
		:ls_CGC_Forn,
		:ll_Volumes
From nf_agendamento_ent
Where de_chave_acesso = :as_Chave_Acesso
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
	Case 100
		as_Mensagem = "Nova fiscal n$$HEX1$$e300$$ENDHEX$$o localizada [" + as_Chave_Acesso + "]."
		Return False
	Case -1
		as_Mensagem = "Erro ao localizar os dados na nota fiscal [" + as_Chave_acesso +  "]. " + SqlCa.SqlErrText
		Return False
End Choose

If ll_Volumes = 0 Then
	select count(*)
	Into	:ll_Qtde
	from fornecedor				a
	inner join cidade				b	on		b.cd_cidade					= a.cd_cidade
	inner join distribuidora_uf	c	on		c.cd_distribuidora			= a.cd_fornecedor
											and	c.cd_unidade_federacao	= b.cd_unidade_federacao
	where a.nr_cgc							= :ls_CGC_Forn
	  and c.id_homologando_pedido	= 'N'
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_Mensagem = "Erro ao verificar se o fornecedor $$HEX1$$e900$$ENDHEX$$ distribuidora: "+SqlCa.SqlErrText
		Return False
	End If
	
	//Se a qtde for maior que zero $$HEX1$$e900$$ENDHEX$$ distribuidora, se for igual a zero $$HEX1$$e900$$ENDHEX$$ fornecedor. 
	//Para distribuidora n$$HEX1$$e300$$ENDHEX$$o precisa fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o porque o sistema calcula a quantidade de volumes ao enviar a nota para o portal da Entregou.com
	If ll_Qtde = 0 Then
		If Not of_grava_divergencia_agend("N$$HEX1$$e300$$ENDHEX$$o foi informado a quantidade de volumes na nota.", 12, "", "", Ref as_mensagem, as_chave_acesso, 0 ) Then
			Return False
		End If
	End If
End If

If Not of_valida_CNPJ_Fornecedor_Cadastrado(ls_CGC_Forn, Ref as_mensagem, as_chave_acesso) Then Return False

If Not IsNull(ll_Pedido) Then
	If Not of_Valida_Cnpj_Fornecedor(ls_CGC_Forn, ll_Pedido, Ref as_mensagem, as_chave_acesso) Then Return False
	
	If Not of_Valida_Data_Emissao_Pedido(ll_Pedido, adh_Emissao_Nf, Ref as_mensagem) Then
		If Not of_grava_divergencia_agend(as_mensagem, 12, "", "", Ref as_mensagem, as_chave_acesso, 0 ) Then
			Return False
		End If
	Else
		// N$$HEX1$$e300$$ENDHEX$$o efetua quando a nota veio via GRC
		If Not of_valida_meta_compra(ll_Pedido, Ref as_mensagem, as_chave_acesso) Then
			Return False
		End If
	End If
End If

// Primeio o sistema verifca se existem produtos sem c$$HEX1$$f300$$ENDHEX$$digo do Sybase, chama outra fun$$HEX2$$e700e300$$ENDHEX$$o para fazer outras valida$$HEX2$$e700f500$$ENDHEX$$es no pedido
If Not of_valida_produtos_pedido(as_chave_acesso, ll_Pedido, ls_CGC_Forn, as_mensagem) Then Return False

// Se for SAP, se tiver com alguma diverg$$HEX1$$ea00$$ENDHEX$$ncia retorna com erro e faz rollback
If Not of_Libera_Nf_Para_Agendamento(as_chave_acesso, Ref as_mensagem) Then Return False

Return True
end function

public function boolean of_valida_pedido (t_infnfe at_infnfe, string as_chave_acesso, date adt_emissao_nf, ref string as_mensagem_log, ref string as_mensagem_pbm);Boolean lb_Erro

Long ll_Pedido_PBM

SetNull(ivl_Pedido)

If of_Valida_Pedido(at_infnfe, Ref ivl_Pedido, Ref as_mensagem_log) Then
	If Not of_Valida_Pedido_Ativo(ivl_Pedido, Ref as_mensagem_log) Then
		If Not of_grava_divergencia_agend(as_mensagem_log, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 ) Then
			Return False
		End If
	ElseIf Not of_Valida_Cnpj_Pedido(at_InfNFe.emit.cnpj, ivl_Pedido, Ref as_Mensagem_Log) Then
		If Not of_grava_divergencia_agend(as_mensagem_log, 2, "", "", Ref as_mensagem_log, as_chave_acesso, 0 ) Then 
			Return False
		End If
	ElseIf Not of_Valida_Data_Emissao_Pedido(ivl_Pedido, adt_Emissao_Nf, Ref as_mensagem_log) Then
		If Not of_grava_divergencia_agend(as_mensagem_log, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 ) Then
			Return False
		End If		
	Else
		If Not of_Valida_Meta_Compra(ivl_Pedido, Ref as_Mensagem_Log, as_chave_acesso) Then
			Return False
//			If Not of_grava_divergencia_agend(as_mensagem_log, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 ) Then
//				Return False
//			End If
		End If
	End If
Else	
	If of_Inclui_Pedido_PBM( at_infnfe, Ref ll_Pedido_PBM,  Ref as_mensagem_pbm, as_chave_acesso, ref lb_Erro ) Then
		ivl_Pedido = ll_Pedido_PBM
	Else		
		If Not of_grava_divergencia_agend( as_mensagem_log, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 ) Then
			Return False
		End If
	End If
	
	If lb_Erro Then Return False
End If

Return True
end function

public function boolean of_verifica_distribuidora_sc (string as_fornecedor, ref string as_mensagem_log);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From fornecedor f
	Inner Join distribuidora_uf d
		On d.cd_distribuidora = f.cd_fornecedor
Where f.cd_fornecedor = :as_Fornecedor
	And f.cd_fornecedor <> '053404705'
	And f.id_distribuidora = 'S'
	And d.cd_unidade_federacao = 'SC'
	And d.id_homologando_pedido = 'N'
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		If ll_Achou > 0 Then
			Return True
		End If
		
	Case 100
		as_mensagem_log = "O fornecedor que faturou a nota n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ uma distribuidora de SC."
		
	Case -1
		as_mensagem_log = "Erro na localizaca$$HEX2$$e700e300$$ENDHEX$$o do fornecedor em 'SC' ." + SqlCa.SqlErrText		
End Choose

Return False
end function

public function boolean of_valida_pedido_distribuidora (long al_pedido_distribuidora, ref string as_mensagem_log);DateTime ldh_Inicio

Long ll_Achou

ldh_Inicio = DateTime(RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -30))
				
Select Count(*)
	Into :ll_Achou
From pedido_distribuidora
Where cd_filial = 534
	And nr_pedido_distribuidora = :al_Pedido_distribuidora
	And dh_emissao >= :ldh_Inicio
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido distribuidora " + String(al_Pedido_distribuidora)
	Return False
End If

If ll_Achou > 0 Then
	il_Pedido_Distrib = al_Pedido_distribuidora
	ib_Pedido_Ba = True

	Update pedido_distribuidora
		Set id_situacao = 'F', dh_nota_fiscal = getdate()
	Where cd_filial = 534
		And nr_pedido_distribuidora = :il_Pedido_Distrib
		And dh_emissao >= :ldh_Inicio
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Mensagem_Log = "Erro ao gravar o 'id_situacao' da tabela pedido_distrbuidora. " + SqlCa.SqlErrText
		SqlCa.of_Rollback()
		Return False
	End If
End If

Return True
end function

protected function boolean of_insere_nf_agendamento_item (t_infnfe a_infnfe, string as_chave_acesso, ref string as_mensagem_log);Long	ll_Itens,&
		i,&
		ll_Qtde_Fat_Trib,&
		ll_Nr_Classificacao_Fiscal,&
		ll_NatOp,&
		ll_Produto_Ped,&
		ll_NrItem,&
		ll_Id_Motivo_Desoneracao_Icms,&
		ll_Produto

String	ls_Cd_Produto_Xml,&
		ls_Ean_Xml,&
		ls_Cd_Cst_Origem,&
		ls_Cd_Cst_Tributacao,&
		ls_Nome_PRD,&
		ls_Chave,&
		ls_Achou,&
		ls_Red_ICMS,&		
		ls_Cd_Mod_Bc_Icms,&
		ls_Cst_Pis_XML,&
		ls_Cst_Cofins_XML,& 
		ls_Cst_Pis_Entrada,&
		ls_Cst_Cofins_Entrada,& 
		ls_cd_unidade_comercial,&
		ls_cd_unidade_tributavel,&
		ls_Cbenef,&
		ls_cd_mod_bc_st,&
		ls_cd_cest
		
Decimal	ldc_Vl_Preco_Unitario,&
			ldc_Vl_Preco_Unit_Trib,&
			ldc_Pc_Desconto,&
			ldc_Pc_Icms,&
			ldc_Vipi,&
			ldc_Vbc_IPI,&
			ldc_Pc_Ipi,&
			ldc_bc_icms,&
			ldc_Pc_Reducao_Base_Icms,&
			ldc_Vl_Bc_Icms_St_Total,&
			ldc_Vl_Icms_St_Total,&
			ldc_Vl_Outras_Despesas,&
			ldc_Pc_Icms_St,&
			ldc_Frete,&
			ldc_Seguro,&
			ldc_ICMS,&
			ldc_Red_BC_ST,&
			ldc_Vl_Preco_Unitario_Original,&
			ldc_Vl_Bc_Icms_St_Original,&
			ldc_Vl_Icms_St_Original,&
			ldc_Bc_Icms_Original,&
			ldc_Vl_Icms_Original,&
			ldc_Vbc_IPI_Original,&
			ldc_Vipi_Original,&			
			ldc_Vl_Icms_Operacao,&
			ldc_Pc_Dif_Icms,&
			ldc_Vl_Icms_Dif,&
			ldc_Bc_Pis_XML,&
			ldc_Pc_Pis_XML,&
			ldc_Vl_Pis_XML,&
			ldc_Bc_Cofins_XML, &
			ldc_Pc_Cofins_XML, &
			ldc_Vl_Cofins_XML, &
			ldc_Bc_Pis_Entrada,&
			ldc_Pc_Pis_Entrada,&
			ldc_Vl_Pis_Entrada,&
			ldc_Bc_Cofins_Entrada, &
			ldc_Pc_Cofins_Entrada, &
			ldc_Vl_Cofins_Entrada, &
			ldc_Vl_Bc_Icms_St_Retido, &
			ldc_Vl_Icms_St_Retido,&
			ldc_Qtde_Fat,&
			ldc_Qtde_Fat_Original,&
			ldc_qt_tributavel,&			
			ldc_qt_comercial,&
			ldc_pc_st_retido,&
			ldc_vl_icms_retido,&
			ldc_pc_mva,&
			ldc_Vl_Icms_Desonerado, &
			ldc_Vl_BC_ST_FCP, &
			ldc_Vl_ST_FCP

String ls_Ean_Trib

Decimal 	ldc_Vl_Desconto_Total,&
			ldc_Vl_Prod_Bruto

String 	ls_cd_cst_is, ls_cd_classificacao_trib_is, ls_cd_un_trib_is, ls_cd_cst_ibscbs, ls_cd_class_trib_ibscbs, ls_cd_cst_ibscbs_reg, &
			ls_cd_class_trib_ibscbs_reg
Dec{2}	ldc_vl_bc_is, ldc_vl_is, ldc_vl_bc_ibscbs, ldc_vl_ibs, ldc_vl_ibs_uf, ldc_vl_dif_ibs_uf, ldc_vl_dev_trib_ibs_uf, &
			ldc_vl_ibs_mun, ldc_vl_dif_ibs_mun, ldc_vl_dev_trib_ibs_mun, ldc_vl_dif_cbs, ldc_vl_dev_trib_cbs, ldc_vl_cbs, ldc_vl_trib_reg_ibs_uf, &
			ldc_vl_trib_reg_ibs_mun, ldc_vl_trib_reg_cbs
Dec{4}	ldc_pc_is, ldc_pc_is_espec, ldc_qt_trib_is, ldc_pc_ibs_uf, ldc_pc_dif_ibs_uf, ldc_pc_reducao_ibs_uf, ldc_pc_efetiva_ibs_uf, &
			ldc_pc_ibs_mun, ldc_pc_dif_ibs_mun, ldc_pc_reducao_ibs_mun, ldc_pc_efetiva_ibs_mun, ldc_pc_cbs, ldc_pc_dif_cbs, ldc_pc_reducao_cbs, &
			ldc_pc_efetiva_cbs, ldc_pc_efetiva_reg_ibs_uf, ldc_pc_efetiva_reg_ibs_mun, ldc_pc_efetiva_reg_cbs


Try
	ll_Itens = UpperBound(a_InfNFe.det[])
		
	For i = 1 to  ll_Itens
		
		ldc_Qtde_Fat 			= Round(a_InfNFe.det[i].prod.qCom, 4)
		ll_Qtde_Fat_Trib		= a_InfNFe.det[i].prod.qTrib
		
		ls_Cd_Produto_Xml 	=	a_InfNFe.det[i].prod.cProd
		ls_Ean_Xml				= 	trim(a_InfNFe.det[i].prod.cEan)
		ls_Ean_Trib				= 	Trim(a_InfNFe.det[i].prod.ceantrib)
		
		ls_Nome_PRD			= a_InfNFe.det[i].prod.xprod
		
		/***************Campos novos********************/
		ll_NrItem						= Long(a_InfNFe.det[i].nitem) 
		ldc_Vl_Desconto_Total	= a_InfNFe.det[i].prod.vDesc
		ldc_Vl_Prod_Bruto			= a_InfNFe.det[i].prod.vProd
		ls_cd_unidade_comercial	= a_InfNFe.det[i].prod.uCom
		ldc_qt_comercial			= a_InfNFe.det[i].prod.qCom
		ls_cd_unidade_tributavel	= a_InfNFe.det[i].prod.uTrib
		ldc_qt_tributavel			= round(a_InfNFe.det[i].prod.qTrib, 4)
		ls_cd_cest				    = a_InfNFe.det[i].prod.cest	
		/**********************************************/
		
			
		ls_Chave = "(Filial: 534 - Chave: " +  as_chave_acesso + " - EAN: " + ls_Ean_Xml + ")"		
			 
		ldc_Vl_Preco_Unitario		= round(a_InfNFe.det[i].prod.vUnCom, 2)
		ldc_Vl_Preco_Unit_Trib	= round(a_InfNFe.det[i].prod.vUnTrib, 2)
		
		//ldc_Pc_Desconto 					= round((a_InfNFe.det[i].prod.vDesc /(ll_Qtde_Fat * a_InfNFe.det[i].prod.vUnCom))* 100, 2)
		If ldc_Qtde_Fat = 0 Then
			ldc_Pc_Desconto		= 0
		Else
			//ldc_Pc_Desconto 		= round(((a_InfNFe.det[i].prod.vDesc + ldc_Vl_ICMS_Deson) /(ldc_Qtde_Fat * a_InfNFe.det[i].prod.vUnCom))* 100, 2)
			ldc_Pc_Desconto 		= round((a_InfNFe.det[i].prod.vDesc  / (ldc_Qtde_Fat * a_InfNFe.det[i].prod.vUnCom))* 100, 2)
		End If
		
		If ldc_Pc_Desconto < 0.00 Or ldc_Pc_Desconto > 100.00 Then
			as_Mensagem_Log = "PC desconto invalido. EAN: " + ls_Ean_Xml
			Return False
		End If
		
		If a_InfNFe.det[i].imposto.IPI.TipoIpi = "IPITrib" Then
			ldc_Vipi 		= round(a_InfNFe.det[i].imposto.IPI.IPITrib.vIPI, 2)
			ldc_Vbc_IPI 	= round(a_InfNFe.det[i].imposto.IPI.IPITrib.vBC, 2)
			ldc_Pc_Ipi 	= round(a_InfNFe.det[i].imposto.ipi.IPITrib.pIPI, 2)
		Else
			ldc_Vipi 		= 0
			ldc_Vbc_IPI 	= 0
			ldc_Pc_Ipi = 0
		End If
				
		ldc_bc_icms 						= round(a_InfNFe.det[i].imposto.ICMS.vBC, 2)
		ldc_Pc_Reducao_Base_Icms		= round(a_InfNFe.det[i].imposto.ICMS.pRedBC	,2)
		ldc_Pc_Icms 						= round(a_InfNFe.det[i].imposto.ICMS.pICMS,2)
		ldc_ICMS								= round(a_InfNFe.det[i].imposto.ICMS.vicms,2)
		
		ldc_Vl_Bc_Icms_St_Total 		= round(a_InfNFe.det[i].imposto.ICMS.vBCST,2)			
		ldc_Pc_Icms_St 					= round(a_InfNFe.det[i].imposto.ICMS.pICMSST,2)
		ldc_Vl_Icms_St_Total 			= round(a_InfNFe.det[i].imposto.ICMS.vICMSST,2)
		ldc_Red_BC_ST					= round(a_InfNFe.det[i].imposto.ICMS.predbcst,2)	
							
		ldc_Vl_Outras_Despesas 		= round(a_InfNFe.det[i].prod.vOutro, 2) // Valor total
			
		ls_Cd_Cst_Origem 				= String(a_InfNFe.det[i].imposto.ICMS.orig)
		ls_Cd_Cst_Tributacao 			= a_InfNFe.det[i].imposto.ICMS.CST
				
		ll_Nr_Classificacao_Fiscal 		= a_InfNFe.det[i].prod.NCM
		ll_NatOp								= Long(a_InfNFe.det[i].prod.cfop)
		
		ldc_Frete 							= round(a_InfNFe.det[i].prod.vfrete,2)
		ldc_Seguro 							= round(a_InfNFe.det[i].prod.vseg,2)
		
		ll_Produto_Ped						= a_InfNFe.det[i].prod.nitemped
		
		ldc_Vl_Preco_Unitario_Original	= round(a_InfNFe.det[i].prod.vUnCom, 4)
		ldc_Qtde_Fat_Original			= round(a_InfNFe.det[i].prod.qCom, 4)
		ldc_Vl_Bc_Icms_St_Original		= round(a_InfNFe.det[i].imposto.ICMS.vBCST,4)
		ldc_Vl_Icms_St_Original			= round(a_InfNFe.det[i].imposto.ICMS.vICMSST,4)
		ldc_Bc_Icms_Original				= round(a_InfNFe.det[i].imposto.ICMS.vBC, 4)
		ldc_Vl_Icms_Original				= round(a_InfNFe.det[i].imposto.ICMS.vicms,4)
		
		If a_InfNFe.det[i].imposto.IPI.TipoIpi = "IPITrib" Then
			ldc_Vipi_Original 				= round(a_InfNFe.det[i].imposto.IPI.IPITrib.vIPI, 4)
			ldc_Vbc_IPI_Original 			= round(a_InfNFe.det[i].imposto.IPI.IPITrib.vBC, 4)
		Else
			ldc_Vipi_Original 				= 0
			ldc_Vbc_IPI_Original 			= 0
		End If
		
		If ldc_Pc_Reducao_Base_Icms > 0 Then
			ls_Red_ICMS = 'S'
		Else
			ls_Red_ICMS = 'N'
		End If
		
		/***************Campos novos********************/
		ls_Cd_Mod_Bc_Icms		= String(a_InfNFe.det[i].imposto.icms.modBC)
		//ls_Cd_Cst_Pis				= String(a_InfNFe.det[i].imposto.pis.pisaliq.CST)
		//ls_Cd_Cst_Cofins		= String(a_InfNFe.det[i].imposto.cofins.COFINSAliq.CST)
		
		ldc_Vl_Icms_Operacao	= round(a_InfNFe.det[i].imposto.icms.vICMSOp, 4)
		ldc_Pc_Dif_Icms			= round(a_InfNFe.det[i].imposto.icms.pDif, 2)
		ldc_Vl_Icms_Dif			= round(a_InfNFe.det[i].imposto.icms.vICMSDif, 4)
		//ldc_Vl_Pis					= round(a_InfNFe.det[i].imposto.pis.pisaliq.vpis, 4)
		//ldc_Vl_Cofins				= round(a_InfNFe.det[i].imposto.cofins.cofinsaliq.vcofins	, 4)
		/**********************************************/
		
		ldc_Vl_Bc_Icms_St_Retido	= round(a_InfNFe.det[i].imposto.ICMS.vBCSTRet, 4)
		ldc_Vl_Icms_St_Retido		= round(a_InfNFe.det[i].imposto.ICMS.vICMSSTRet, 4)
		
		/**************Campos novos*************************/
		ldc_pc_st_retido			=	round(a_InfNFe.det[i].imposto.ICMS.pST, 2)
		ldc_vl_icms_retido			=  round(a_InfNFe.det[i].imposto.ICMS.vICMSSubstituto, 4)
		/**********************************************/
			
		
		// Novos Campos
		ldc_Vl_Desconto_Total		= round(ldc_Vl_Desconto_Total,2)
		ldc_Vl_Prod_Bruto				= round(ldc_Vl_Prod_Bruto,2)
		
		ls_Cbenef			= a_InfNFe.det[i].prod.cBenef
		ls_cd_mod_bc_st	= String(a_InfNFe.det[i].imposto.ICMS.modBCST)
		ldc_pc_mva			= round(a_InfNFe.det[i].imposto.ICMS.pMVAST, 4)
		
		If Trim(ls_Cbenef) = "" Then SetNull(ls_Cbenef)
		If Trim(ls_cd_mod_bc_st) = "" Then SetNull(ls_cd_mod_bc_st)
		
		ldc_Vl_Icms_Desonerado = round(a_InfNFe.det[i].imposto.ICMS.vICMSDeson,2)
		
		If a_InfNFe.det[i].imposto.ICMS.motDesICMS <> '' And Not IsNull(a_InfNFe.det[i].imposto.ICMS.motDesICMS) Then
			ll_Id_Motivo_Desoneracao_Icms = Long(a_InfNFe.det[i].imposto.ICMS.motDesICMS)
		Else
			Setnull(ll_Id_Motivo_Desoneracao_Icms)
		End If
		
		ldc_Vl_BC_ST_FCP	= round(a_InfNFe.det[i].imposto.ICMS.VBCFCPST, 4)
		ldc_Vl_ST_FCP			= round(a_InfNFe.det[i].imposto.ICMS.VFCPST, 4)
		
		/* PIS e COFINS */
		//Tributa$$HEX2$$e700e300$$ENDHEX$$o de entrada est$$HEX1$$e100$$ENDHEX$$ na confirma$$HEX2$$e700e300$$ENDHEX$$o do agendamento
		SetNull(ls_CST_PIS_Entrada)
		SetNull(ldc_Bc_PIS_Entrada)
		SetNull(ldc_Pc_PIS_Entrada)
		SetNull(ldc_Vl_PIS_Entrada)
		SetNull(ls_CST_Cofins_Entrada)
		SetNull(ldc_Bc_Cofins_Entrada)
		SetNull(ldc_Pc_Cofins_Entrada)
		SetNull(ldc_Vl_Cofins_Entrada)

		// PIS do XML
		Choose Case Lower(a_InfNFe.det[i].imposto.pis.tipopis)
			Case "pisnt"
				ls_CST_PIS_XML	=	a_InfNFe.det[i].imposto.pis.pisnt.cst
				ldc_BC_PIS_XML	=	0.00
				ldc_PC_PIS_XML	=	0.00
				ldc_VL_PIS_XML	=	0.00
			Case "pisaliq"
				ls_CST_PIS_XML	=	a_InfNFe.det[i].imposto.pis.pisaliq.cst
				ldc_BC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisaliq.vbc, 2)
				ldc_PC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisaliq.ppis, 2)
				ldc_VL_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisaliq.vpis, 4)
			Case "pisqtde"
				ls_CST_PIS_XML	=	a_InfNFe.det[i].imposto.pis.pisqtde.cst
				ldc_BC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisqtde.qbcprod, 2)
				ldc_PC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisqtde.valiqprod, 2)
				ldc_VL_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisqtde.vpis, 4)
			Case "pisoutr"
				ls_CST_PIS_XML	=	a_InfNFe.det[i].imposto.pis.pisoutr.cst
				ldc_BC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisoutr.vbc, 2)
				ldc_PC_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisoutr.ppis, 2)
				ldc_VL_PIS_XML	=	round(a_InfNFe.det[i].imposto.pis.pisoutr.vpis, 4)
			Case  ""
				as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do PIS e COFINS no XML."+ SqlCa.SQLErrText
				Return False
		End Choose
		
		// COFINS do XML
		Choose Case Lower(a_InfNFe.det[i].imposto.cofins.tipocofins)
			Case "cofinsnt"
				ls_CST_Cofins_XML	=	a_InfNFe.det[i].imposto.cofins.cofinsnt.cst
				ldc_BC_Cofins_XML	=	0.00
				ldc_PC_Cofins_XML	=	0.00
				ldc_VL_Cofins_XML	=	0.00
			Case "cofinsaliq"
				ls_CST_Cofins_XML	=	a_InfNFe.det[i].imposto.cofins.cofinsaliq.cst
				ldc_BC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsaliq.vbc, 2)
				ldc_PC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsaliq.pCofins, 2)
				ldc_VL_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsaliq.vCofins, 4)
			Case "cofinsqtde"
				ls_CST_Cofins_XML	=	a_InfNFe.det[i].imposto.cofins.cofinsqtde.cst
				ldc_BC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsqtde.qbcprod, 2)
				ldc_PC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsqtde.valiqprod, 2)
				ldc_VL_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsqtde.vcofins, 4)
			Case "cofinsoutr"
				ls_CST_Cofins_XML	=	a_InfNFe.det[i].imposto.cofins.cofinsoutr.cst
				ldc_BC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsoutr.vbc, 2)
				ldc_PC_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsoutr.pcofins, 2)
				ldc_VL_Cofins_XML	=	round(a_InfNFe.det[i].imposto.cofins.cofinsoutr.vcofins, 4)
			Case  ""
				as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do PIS e COFINS no XML."+ SqlCa.SQLErrText
				Return False
		End Choose
		
		//IS
		ls_cd_cst_is						= a_InfNFe.det[i].imposto.ISEL.cstis
		ls_cd_classificacao_trib_is	= a_InfNFe.det[i].imposto.ISEL.cClassTribIS
		ldc_vl_bc_is						= a_InfNFe.det[i].imposto.ISEL.vBCIS
		ldc_pc_is							= a_InfNFe.det[i].imposto.ISEL.pIS
		ldc_pc_is_espec					= a_InfNFe.det[i].imposto.ISEL.pISEspec
		ls_cd_un_trib_is					= a_InfNFe.det[i].imposto.ISEL.uTrib
		ldc_qt_trib_is						= a_InfNFe.det[i].imposto.ISEL.qTrib
		ldc_vl_is							= a_InfNFe.det[i].imposto.ISEL.vIS

		//IBSCBS
		ls_cd_cst_ibscbs					= a_InfNFe.det[i].imposto.IBSCBS.CST
		ls_cd_class_trib_ibscbs			= a_InfNFe.det[i].imposto.IBSCBS.cClassTrib
		ldc_vl_bc_ibscbs					= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.vBC

		//IBS
		ldc_vl_ibs							= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.vIBS

		//IBSUF
		ldc_pc_ibs_uf						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.pibsuf
		ldc_vl_ibs_uf						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.vibsuf
		ldc_pc_dif_ibs_uf					= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gDif.pdif
		ldc_vl_dif_ibs_uf					= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gDif.vdif
		ldc_vl_dev_trib_ibs_uf			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gDevTrib.vdevtrib
		ldc_pc_reducao_ibs_uf			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gred.predaliq
		ldc_pc_efetiva_ibs_uf			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSUF.gred.paliqefet
		
		//IBSMUN
		ldc_pc_ibs_mun						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.pibsmun
		ldc_vl_ibs_mun						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.vibsmun
		ldc_pc_dif_ibs_mun 				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gDif.pdif
		ldc_vl_dif_ibs_mun				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gDif.vdif
		ldc_vl_dev_trib_ibs_mun			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gDevTrib.vdevtrib
		ldc_pc_reducao_ibs_mun			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gred.predaliq
		ldc_pc_efetiva_ibs_mun			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gIBSMun.gred.paliqefet

		//CBS
		ldc_pc_cbs							= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.pcbs
		ldc_pc_dif_cbs						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gDif.pdif
		ldc_vl_dif_cbs						= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gDif.vdif
		ldc_vl_dev_trib_cbs				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gDevTrib.vdevtrib
		ldc_pc_reducao_cbs				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gred.predaliq
		ldc_pc_efetiva_cbs				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.gred.paliqefet
		ldc_vl_cbs 							= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gCBS.vcbs

		//IBSCBS Regular
		ls_cd_cst_ibscbs_reg 			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.cstreg
		ls_cd_class_trib_ibscbs_reg	= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.cClassTribReg

		//IBSUF
		ldc_pc_efetiva_reg_ibs_uf		= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.pAliqEfetRegIBSUF
		ldc_vl_trib_reg_ibs_uf			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.vTribRegIBSUF
		
		//IBSMUN
		ldc_pc_efetiva_reg_ibs_mun		= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.pAliqEfetRegIBSMun
		ldc_vl_trib_reg_ibs_mun			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.vTribRegIBSMun
		
		//CBS
		ldc_pc_efetiva_reg_cbs			= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.pAliqEfetRegCBS
		ldc_vl_trib_reg_cbs				= a_InfNFe.det[i].imposto.IBSCBS.gIBSCBS.gtribregular.vTribRegCBS
		
		If Not of_Valida_Produto_Xml(a_InfNFe.det[i].prod.nitemped, a_InfNFe.det[i].prod.cprod, ls_Ean_Xml, ls_Ean_Trib, a_InfNFe.emit.cnpj, a_InfNFe.det[i].prod.xprod,  a_InfNFe.det[i].prod.qcom, Ref as_Mensagem_Log, '', 0, ref ll_Produto, True) Then
			Return False
		End If
		
		Select de_chave_acesso
		Into :ls_Achou
		From nf_agendamento_ent_item
		Where de_chave_acesso 	= :as_chave_acesso
			and nr_item = :i
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				Return True // S$$HEX1$$f300$$ENDHEX$$ verifica uma vez.
			Case 100
				
				  INSERT INTO nf_agendamento_ent_item  ( 
						de_chave_acesso,   
						nr_item,   
						cd_produto,   
						cd_cprod,   
						de_codigo_barras,   
						de_produto,   
						nr_classificacao_fiscal,   
						cd_natureza_operacao,   
						qt_faturada, 
						qt_tributada,
						vl_preco_unitario,   
						vl_preco_unitario_tributado,
						pc_desconto,   
						vl_frete,   
						vl_seguro,   
						nr_item_pedido,   
						cd_cst_origem,   
						cd_cst_tributacao,   
						vl_bc_icms,   
						pc_reducao_bc_icms,   
						pc_icms,   
						vl_icms,   
						vl_bc_icms_st,   
						pc_reducao_bc_icms_st,   
						pc_icms_st,   
						vl_icms_st,   
						vl_bc_ipi,   
						pc_ipi,   
						vl_ipi,   
						vl_outras_despesas, 
						de_codigo_barras_trib,
						qt_faturada_original,
						vl_preco_unitario_original,
						vl_bc_icms_st_original,
						vl_icms_st_original,
						vl_bc_icms_original,
						vl_icms_original,
						vl_bc_ipi_original,
						vl_ipi_original,
						id_reducao_base_icms,																	  
						cd_mod_bc_icms,
						vl_icms_operacao,
						pc_dif_icms,
						vl_icms_dif,
						cd_cst_pis,
						vl_bc_pis_xml,
						pc_pis_xml,
						vl_pis,
						cd_cst_cofins,
						vl_bc_cofins_xml,
						pc_cofins_xml,
						vl_cofins,
						vl_bc_icms_st_retido,
						vl_icms_st_retido,
						vl_bc_icms_st_retido_original,
						vl_icms_st_retido_original, 
						nr_sequencial, 
						vl_desconto_total, 
						vl_total_item,
						cd_unidade_comercial,
						cd_unidade_tributavel, 
						qt_comercial,					
						qt_tributavel,
						pc_st_retido,
						vl_icms_retido,
						cd_beneficio,
						cd_mod_bc_st,
						pc_mva,
						cd_cest,
						vl_icms_desonerado,
						id_motivo_desoneracao_icms,
						vl_bc_st_fcp,
						vl_st_fcp,
						cd_cst_pis_entrada,
						vl_bc_pis_entrada,
						pc_pis_entrada,
						vl_pis_entrada,
						cd_cst_cofins_entrada,
						vl_bc_cofins_entrada,
						pc_cofins_entrada,
						vl_cofins_entrada,
						cd_cst_is,
						cd_classificacao_trib_is,
						vl_bc_is,
						pc_is,
						pc_is_espec,
						cd_un_trib_is,
						qt_trib_is,
						vl_is,
						cd_cst_ibscbs,
						cd_class_trib_ibscbs,
						vl_bc_ibscbs,
						vl_ibs,
						pc_ibs_uf,
						vl_ibs_uf,
						pc_dif_ibs_uf,
						vl_dif_ibs_uf,
						vl_dev_trib_ibs_uf,
						pc_reducao_ibs_uf,
						pc_efetiva_ibs_uf,
						pc_ibs_mun,
						vl_ibs_mun,
						pc_dif_ibs_mun,
						vl_dif_ibs_mun,
						vl_dev_trib_ibs_mun,
						pc_reducao_ibs_mun,
						pc_efetiva_ibs_mun,
						pc_cbs,
						pc_dif_cbs,
						vl_dif_cbs,
						vl_dev_trib_cbs,
						pc_reducao_cbs,
						pc_efetiva_cbs,
						vl_cbs,
						cd_cst_ibscbs_reg,
						cd_class_trib_ibscbs_reg,
						pc_efetiva_reg_ibs_uf,
						vl_trib_reg_ibs_uf,
						pc_efetiva_reg_ibs_mun,
						vl_trib_reg_ibs_mun,
						pc_efetiva_reg_cbs,
						vl_trib_reg_cbs)  
				  VALUES (	:as_chave_acesso,					//de_chave_acesso,   
								:i,											//nr_item,   
								null,										//cd_produto,   
								:ls_Cd_Produto_Xml,					//cd_cprod,   
								:ls_Ean_Xml,							//de_codigo_barras,   
								:ls_Nome_PRD,							//de_produto,   
								:ll_Nr_Classificacao_Fiscal,			//nr_classificacao_fiscal,   
								:ll_NatOp,								//cd_natureza_operacao,   
								:ldc_Qtde_Fat, 							//qt_faturada,   
								:ll_Qtde_Fat_Trib,						//qt_tributada,
								:ldc_Vl_Preco_Unitario,				//vl_preco_unitario, 
								:ldc_Vl_Preco_Unit_Trib,				//vl_preco_unitario_tributado,
								:ldc_Pc_Desconto,						//pc_desconto,   
								:ldc_Frete,								//vl_frete,   
								:ldc_Seguro,							//vl_seguro,   
								:ll_Produto_Ped,						//nr_item_pedido,   
								:ls_Cd_Cst_Origem,					//cd_cst_origem,   
								:ls_Cd_Cst_Tributacao,				//cd_cst_tributacao,   
								:ldc_bc_icms,							//vl_bc_icms,   
								:ldc_Pc_Reducao_Base_Icms,		//pc_reducao_bc_icms,   
								:ldc_Pc_Icms,							//pc_icms,   
								:ldc_ICMS,								//vl_icms,   
								:ldc_Vl_Bc_Icms_St_Total,			//vl_bc_icms_st,   
								:ldc_Red_BC_ST,						//pc_reducao_bc_icms_st,   
								:ldc_Pc_Icms_St,						//pc_icms_st,   
								:ldc_Vl_Icms_St_Total,				//vl_icms_st,   
								:ldc_Vbc_IPI,							//vl_bc_ipi,   
								:ldc_Pc_Ipi,								//pc_ipi,   
								:ldc_Vipi,									//vl_ipi,   
								:ldc_Vl_Outras_Despesas, 			//vl_outras_despesas
								:ls_Ean_Trib,							//de_codigo_barras_trib
								:ldc_Qtde_Fat_Original,				//qt_faturada_original
								:ldc_Vl_Preco_Unitario_Original,	//vl_preco_unitario_original
								:ldc_Vl_Bc_Icms_St_Original,		//vl_bc_icms_st_original
								:ldc_Vl_Icms_St_Original,			//vl_icms_st_original
								:ldc_Bc_Icms_Original,				//vl_bc_icms_original
								:ldc_Vl_Icms_Original,				//vl_icms_original
								:ldc_Vbc_IPI_Original,				//vl_bc_ipi_original
								:ldc_Vipi_Original,						//vl_ipi_original
								:ls_Red_ICMS,							//id_reducao_base_icms
								:ls_Cd_Mod_Bc_Icms,					//cd_mod_bc_icms
								:ldc_Vl_Icms_Operacao,				//vl_icms_operacao
								:ldc_Pc_Dif_Icms,						//pc_dif_icms				
								:ldc_Vl_Icms_Dif,						//vl_icms_dif
								:ls_Cst_Pis_XML,						//cd_cst_pis
								:ldc_Bc_Pis_XML,						//vl_bc_pis_xml
								:ldc_Pc_Pis_XML,						//pc_pis_xml
								:ldc_Vl_Pis_XML,						//vl_pis
								:ls_Cst_Cofins_XML,					//cd_cst_cofins
								:ldc_Bc_Cofins_XML,					//vl_bc_cofins_xml
								:ldc_Pc_Cofins_XML,					//pc_cofins_xml
								:ldc_Vl_Cofins_XML,					//vl_cofins
								:ldc_Vl_Bc_Icms_St_Retido,			//vl_bc_icms_st_retido
								:ldc_Vl_Icms_St_Retido,				//vl_icms_st_retido 
								:ldc_Vl_Bc_Icms_St_Retido,			//vl_bc_icms_st_retido_original
								:ldc_Vl_Icms_St_Retido,				//vl_icms_st_retido_original 
								:ll_NrItem,								// Numero Sequencial NFE do Item
								:ldc_Vl_Desconto_Total, 			    // Valor em Reais do Desconto do Item
								:ldc_Vl_Prod_Bruto,					// Valor Bruto do Item
								:ls_cd_unidade_comercial,			// Unidade Comercial
								:ls_cd_unidade_tributavel,			// Unidade Tributavel
								:ldc_qt_tributavel,						// Quantidade Tributavel
								:ldc_qt_comercial,						// Quantidade Comercial			
								:ldc_pc_st_retido,						// Al$$HEX1$$ed00$$ENDHEX$$quota suportada pelo Consumidor Final
								:ldc_vl_icms_retido,					// Valor do ICMS pr$$HEX1$$f300$$ENDHEX$$prio do Substituto
								:ls_Cbenef,								//cd_beneficio
								:ls_cd_mod_bc_st,						//cd_mod_bc_st
								:ldc_pc_mva,							//pc_mva
								:ls_cd_cest,								//cd_cest
								:ldc_Vl_Icms_Desonerado,			//vl_icms_desonerado
								:ll_Id_Motivo_Desoneracao_Icms,	//id_motivo_desoneracao_icms
								:ldc_Vl_BC_ST_FCP,					//vl_bc_st_fcp
								:ldc_Vl_ST_FCP,						//vl_st_fcp
								:ls_CST_PIS_Entrada, 				//cd_cst_pis_entrada,
								:ldc_Bc_PIS_Entrada,					//vl_bc_pis_entrada,
								:ldc_Pc_PIS_Entrada,					//pc_pis_entrada,
								:ldc_Vl_PIS_Entrada,					//vl_pis_entrada,
								:ls_CST_Cofins_Entrada, 			//cd_cst_cofins_entrada,
								:ldc_Bc_Cofins_Entrada,				//vl_bc_cofins_entrada,
								:ldc_Pc_Cofins_Entrada,				//pc_cofins_entrada,
								:ldc_Vl_Cofins_Entrada,				//vl_cofins_entrada,
								:ls_cd_cst_is,
								:ls_cd_classificacao_trib_is,
								:ldc_vl_bc_is,
								:ldc_pc_is,
								:ldc_pc_is_espec,
								:ls_cd_un_trib_is,
								:ldc_qt_trib_is,
								:ldc_vl_is,
								:ls_cd_cst_ibscbs,
								:ls_cd_class_trib_ibscbs,
								:ldc_vl_bc_ibscbs,
								:ldc_vl_ibs,
								:ldc_pc_ibs_uf,
								:ldc_vl_ibs_uf,
								:ldc_pc_dif_ibs_uf,
								:ldc_vl_dif_ibs_uf,
								:ldc_vl_dev_trib_ibs_uf,
								:ldc_pc_reducao_ibs_uf,
								:ldc_pc_efetiva_ibs_uf,
								:ldc_pc_ibs_mun,
								:ldc_vl_ibs_mun,
								:ldc_pc_dif_ibs_mun,
								:ldc_vl_dif_ibs_mun,
								:ldc_vl_dev_trib_ibs_mun,
								:ldc_pc_reducao_ibs_mun,
								:ldc_pc_efetiva_ibs_mun,
								:ldc_pc_cbs,
								:ldc_pc_dif_cbs,
								:ldc_vl_dif_cbs,
								:ldc_vl_dev_trib_cbs,
								:ldc_pc_reducao_cbs,
								:ldc_pc_efetiva_cbs,
								:ldc_vl_cbs,
								:ls_cd_cst_ibscbs_reg,
								:ls_cd_class_trib_ibscbs_reg,
								:ldc_pc_efetiva_reg_ibs_uf,
								:ldc_vl_trib_reg_ibs_uf,
								:ldc_pc_efetiva_reg_ibs_mun,
								:ldc_vl_trib_reg_ibs_mun,
								:ldc_pc_efetiva_reg_cbs,
								:ldc_vl_trib_reg_cbs)
				Using SqlCa;
					
				If SqlCa.SqlCode  = -1 Then
					as_Mensagem_Log = "Erro no insert do registro [nf_agendamento_ent_item] "+ ls_Chave +": "+ SqlCa.SQLErrText
					SqlCa.of_RollBack();
					Return False
				End If
				
				If Not of_insere_nf_agendamento_item_lote(as_chave_acesso, a_InfNFe.det[i].prod, i, Ref as_mensagem_log) Then Return False
				
				If Not of_atualiza_pedido_distribuidora_produto ( ll_Produto, long(ldc_Qtde_Fat),as_chave_acesso, Ref as_mensagem_log, 1) Then Return False
				
			//	If Not of_atualiza_pedido_distribuidora_produto ( ll_Produto, long(ldc_Qtde_Fat), Ref as_mensagem_log, 1) Then Return False
		Case -1 
			as_Mensagem_Log = "Erro ao localizar a chave de acesso [nf_agendamento_ent_item] "+ ls_Chave +": "+ SqlCa.SQLErrText
			SqlCa.of_RollBack();
			Return False	
			
		End Choose
	
	Next
Catch ( runtimeerror  lo_rte )
	as_Mensagem_Log = "Ocorreu erro ao inserir os itens do agendamento. Objeto 'dc_uo_verifica_divergencia_notas', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_nf_agendamento_item'. Erro: "+lo_rte.GetMessage( )
	SqlCa.of_RollBack();
	Return False			
Finally
	//
End Try	

Return True
end function

public function boolean of_valida_meta_compra (long al_pedido, ref string as_mensagem_log, string as_chave_acesso);Long ll_Qtde
Long ll_Itens
Long ll_Produto
Long ll_Linha

String ls_Mensagem
String ls_Ean
String ls_Xprod

If ib_Iniciado_Operacao_SAP Then Return True

If al_Pedido > 0 Then

	Select count(*) as nr_qtde
		Into :ll_Qtde
	From pedido_central
	Where nr_pedido = :al_Pedido
		And coalesce(id_retira_qtde_pendente_meta, 'N') = 'S'
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case 0
			If ll_Qtde > 0 Then
				ls_Mensagem = "PEDIDO MARCADO PARA DESCONSIDERAR A META DE COMPRA."
				If Not of_grava_divergencia_agend(ls_Mensagem, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 ) Then Return False
				Return True
			End If
			
		Case -1
			as_Mensagem_Log = "Erro ao verificar se $$HEX1$$e900$$ENDHEX$$ para desconsiderar a meta de compra do pedido: " + SqlCa.SqlErrText
			Return False
	End Choose
End If

Try
	
	dc_uo_ds_base lds	
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge238_nf_agendamento_item', False) Then
		as_mensagem_log = "Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW [ds_ge238_nf_agendamento_item]."
		Return False
	End If	
	
	If lds.Retrieve(as_chave_acesso) = -1 Then
		as_mensagem_log = "Erro ao recuperar os dados da DW [ds_ge238_nf_agendamento_item]."
		Return False
	End If

	For ll_Linha = 1 To lds.RowCount()
		ll_Produto		= lds.Object.cd_produto			[ll_Linha]
		ls_Ean			= lds.Object.de_codigo_barras	[ll_Linha]
		ls_Xprod			= lds.Object.de_produto			[ll_Linha]
		
		SetNull(ls_Mensagem)
		
		If ll_Produto > 0 And al_Pedido > 0 Then //Se encontrou o produto e o pedido
		
			Select Count(*)
				Into: ll_Qtde
			From pedido_central_produto
			Where nr_pedido = :al_Pedido
				And cd_produto = :ll_Produto
				And coalesce(id_retira_qtde_pendente_meta, 'N') = 'S'
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Mensagem_Log = "Erro ao verificar se $$HEX1$$e900$$ENDHEX$$ para desconsiderar o produto da meta de compra do pedido" + SqlCa.SqlErrText
				Return False
			End If
			
			If ll_Qtde > 0 Then
				ls_Mensagem = "PRODUTO MARCADO PARA DESCONSIDERAR A META DE COMPRA."
				If Not of_grava_divergencia_agend(ls_Mensagem, 13, ls_Xprod, ls_Ean, Ref as_Mensagem_Log, as_chave_acesso, ll_Linha) Then Return False
			End If
		End If
	Next
		
	Return True

Finally
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean of_valida_cnpj_pedido (string as_cgc_fornecedor, long al_pedido, ref string as_mensagem_log);DateTime	ldt_dh_inicio_nf_remessa, ldt_atual
String 	ls_Cgc_Pedido


select b.nr_cgc 
Into :ls_Cgc_Pedido
from pedido_central a
inner join fornecedor b on b.cd_fornecedor = a.cd_fornecedor
where a.nr_pedido = :al_Pedido
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
		If ls_Cgc_Pedido <> as_cgc_fornecedor Then
			select c.nr_cgc,
					 b.dh_inicio_nf_remessa
			Into :ls_Cgc_Pedido,
				  :ldt_dh_inicio_nf_remessa
			from pedido_central a
			inner join fornecedor b on b.cd_fornecedor = a.cd_fornecedor
			inner join fornecedor c on c.cd_fornecedor = b.cd_fornecedor_nf_remessa
			where a.nr_pedido = :al_Pedido
			Using SqlCa;
			
			Choose Case SQLCA.SQLCode
				Case 0
					ldt_atual = gf_getserverdate()
					
					if ldt_atual > ldt_dh_inicio_nf_remessa then
						If ls_Cgc_Pedido <> as_cgc_fornecedor Then
							as_mensagem_log = "O CNPJ do emissor da nota ("+as_cgc_fornecedor+") $$HEX1$$e900$$ENDHEX$$ diferente do fornecedor do pedido ("+ls_Cgc_Pedido+")"
							Return False
						end if
					else
						as_mensagem_log = "A regra da nota de remessa ainda n$$HEX1$$e300$$ENDHEX$$o entrou em vigor. ("+as_cgc_fornecedor+") $$HEX1$$e900$$ENDHEX$$ diferente do fornecedor do pedido ("+ls_Cgc_Pedido+")"
						Return False
					end if				
				Case -1
					as_Mensagem_Log = "Localizar o CNPJ do fornecedor do pedido. " + SqlCa.SqlErrText
					Return False
				Case 100
					as_mensagem_log = "O CNPJ do emissor da nota ("+as_cgc_fornecedor+") $$HEX1$$e900$$ENDHEX$$ diferente do fornecedor do pedido ("+ls_Cgc_Pedido+")"
					Return False
			End Choose	
		End If
	Case 100
		If Not IsNull(al_Pedido) Then
			as_mensagem_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o CNPJ do fornecedor do pedido '"+String(al_Pedido)
			Return False
		End If	
	Case -1
		as_Mensagem_Log = "Localizar o CNPJ do fornecedor do pedido. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_valida_situacao_tributaria (long al_pedido_central, long al_produto, string as_de_produto, string as_ean, decimal adc_valor_icms, decimal adc_valor_st, string as_tributacao_icms, date adt_emissao, string as_uf_fornecedor, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_xml, string as_situacao_tributaria);Boolean lb_Valida = True

String		ls_Icms_Normal,&
			ls_Icms_St,&
			ls_Grupo,&
			ls_Uf_Fornecedor,&
			ls_Nulo,&
			ls_Tributacao_Cst, &
			ls_fornecedor,&
			ls_Tributacao_Icms_Produto
			
Decimal	ldc_Icms,&
			ldc_Icms_St
Long	ll_Tributacao_Produto,&
		ll_Grupo,&
		ll_Tipo_Produto,&
		ll_Tipo_Produto_Fiscal, &
		ll_excecao
		
Date lvdt_Emissao
		
uo_tipo_produto_fiscal lo_Tipo_Produto		
		
Try
	lo_Tipo_Produto = Create uo_tipo_produto_fiscal
		
	Select c.cd_unidade_federacao,
			 b.cd_fornecedor
	Into :ls_Uf_Fornecedor,
		  :ls_fornecedor
	From pedido_central	a
	inner join fornecedor	b on b.cd_fornecedor	= a.cd_fornecedor
	inner join cidade		c on c.cd_cidade		= b.cd_cidade
	where a.nr_pedido = :al_Pedido_Central
	Using SqlCa;
		
	Choose Case SqlCa.Sqlcode
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da UF do fornecedor'. " + SqlCa.SqlErrText
			Return False
			
		Case 0
		Case 100
			as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a UF do fornecedor'. " + SqlCa.SqlErrText
			Return False
	End Choose
	
	select id_icms_normal,  id_icms_st, cd_cst_tributacao
	Into :ls_Icms_Normal, :ls_Icms_St, :ls_Tributacao_Cst
	from tributacao_icms
	where cd_tributacao_icms = :as_Tributacao_Icms
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da tributa$$HEX2$$e700e300$$ENDHEX$$o do ICMS'. " + SqlCa.SqlErrText
			Return False
		Case 0	
			If (ls_Icms_Normal = 'S') And (adc_valor_icms <= 0.00) Then
				If Not of_grava_divergencia("A situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria '" + as_Tributacao_Icms + "' exige valor de ICMS maior que zero.", 10, as_De_Produto, as_Ean, Ref as_Mensagem_Log, as_chave_acesso, ai_item_xml ) Then
					Return False
				End If
			End If
			
			If (ls_Icms_Normal = 'N') And (adc_valor_icms > 0.00) Then
				lb_Valida = True
				// Fornecedor possui TTD para que possa se creditar parcialmente do imposto
				// A Tyfany esta verificando a possibilidade do fornecedor em alguma tag do XML
				If as_Tributacao_Icms = '5' and ls_fornecedor = '053410505' Then lb_Valida = False
				
				If lb_Valida Then
					If Not of_grava_divergencia("A situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria '" + as_Tributacao_Icms + "' n$$HEX1$$e300$$ENDHEX$$o permite valor de ICMS maior que zero.", 10, as_De_Produto, as_Ean, Ref as_Mensagem_Log, as_chave_acesso, ai_item_xml ) Then
						Return False
					End If
				End If
			End If
			
			If (ls_Icms_St = 'S') And (adc_valor_st <= 0.00) Then
				If Not of_grava_divergencia_Agend("A situacao tribut$$HEX1$$e100$$ENDHEX$$ria '" + as_Tributacao_Icms + "' exige valor de ICMS S.T. maior que zero.", 10, as_De_Produto, as_Ean, Ref as_Mensagem_Log, as_chave_acesso, ai_item_xml ) Then
					Return False
				End If
			End If
			
			If (ls_Icms_St = 'N') And (adc_valor_st > 0.00) Then
				If Not of_grava_divergencia_Agend("A situacao tribut$$HEX1$$e100$$ENDHEX$$ria '" + as_Tributacao_Icms + "' n$$HEX1$$e300$$ENDHEX$$o permite valor de ICMS S.T. maior que zero.", 10, as_De_Produto, as_Ean, Ref as_Mensagem_Log, as_chave_acesso, ai_item_xml ) Then
					Return False
				End If
			End If
			
			//------------------------Perfumaria dentro do estado----------------------------
			If Not IsNull(as_Situacao_Tributaria) Then
				If Not lo_Tipo_Produto.of_grupo_produto_fiscal_uf('SC', al_Produto, as_Tributacao_Icms, ref ll_Grupo) Then
					Return False
				End If
				
				//2 -> Perfumaria
				//5 -> Lamina de barbear
				If (ll_Grupo = 2) or (ll_Grupo = 5)  Then
					If as_Uf_Fornecedor = 'SC' Then
						If (as_Situacao_Tributaria <> '00') and (as_Situacao_Tributaria <> '20') and (as_Situacao_Tributaria <> '41') Then
							If Not of_grava_divergencia_Agend("Para compra de perfumaria dentro do estado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido c$$HEX1$$f300$$ENDHEX$$digo da CST diferente de '00', '20' e '41'.", 10, as_De_Produto, as_Ean, Ref as_Mensagem_Log, as_chave_acesso, ai_item_xml ) Then
								Return False
							End If
						End If
					End If
				End If
			End If
			//-------------------------------------------------------------------------------------			
			
			
			Select cd_tributacao_produto,
					cd_tributacao_icms,
					substring(cd_subcategoria, 1,1)
			Into	:ll_Tributacao_Produto,
					:ls_Tributacao_Icms_Produto,
					:ls_Grupo
			From produto_geral
			Where cd_produto = :al_Produto
			Using SqlCa;
			
			Choose Case SqlCa.Sqlcode
				Case -1
					as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da tributa$$HEX2$$e700e300$$ENDHEX$$o do produto'. " + SqlCa.SqlErrText
					Return False
				Case 0
					If ((as_Tributacao_Icms = '1') or (as_Tributacao_Icms = '7') or  (as_Tributacao_Icms = '6'))  Then
						If Not lo_Tipo_Produto.of_grupo_produto_fiscal_uf('SC', al_Produto, as_Tributacao_Icms, ref ll_Grupo) Then
							Return False
						End If
						If ll_Grupo = 1 Then// Medicamento
							If Not of_grava_divergencia_Agend("A partir de 01/01/2012 medicamentos so podem entrar no sistema sem ST. Produto("+String(al_Produto)+")", 10, "", String(al_Produto), Ref as_Mensagem_Log, as_chave_acesso, ai_item_xml ) Then
								Return False
							End If
						End If
						
//						If Not IsNull(al_Pedido_Central) Then
//							If (as_Tributacao_Icms = '1') or (as_Tributacao_Icms = '7') Then
//								If ll_Grupo = 3 Then// Perfumaria
//									If adc_valor_st > 0.00 Then
//										if Not of_verifica_excecao_regra(al_produto, ls_fornecedor, ref ll_excecao, ref as_Mensagem_Log) then return false
//										
//										if ll_excecao = 0 then
//											If ls_Uf_Fornecedor <> "SC" Then
//												If Not of_grava_divergencia_Agend("Para compra de perfumaria fora do estado com a situa$$HEX2$$e700e300$$ENDHEX$$o tribut$$HEX1$$e100$$ENDHEX$$ria '"+String(as_Tributacao_Icms)+"', n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido valor de S.T. maior do que zero.", 10, as_De_Produto, as_Ean, Ref as_Mensagem_Log, as_chave_acesso, ai_item_xml ) Then
//													Return False
//												End If
//											End If
//										end if
//									End If						
//								End If
//							End If
//						End If
					End If

					If ((as_Tributacao_Icms = '1') or (as_Tributacao_Icms = '6'))  and (ls_Tributacao_Icms_Produto = '0') Then
						If Not of_grava_divergencia_Agend("N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido ST '" + as_Tributacao_Icms + "' para produto com a tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS igual a 'TRIBUTADO INTEGRALMENTE'.", 10, as_De_Produto, as_Ean, Ref as_Mensagem_Log, as_chave_acesso, ai_item_xml ) Then
							Return False
						End If
					End If					
			End Choose
	End Choose
	
Finally
	Destroy(lo_Tipo_Produto)
End Try

Return True
end function

public function boolean of_msg_logistica_exclu_ba (integer ai_log);Date ldt_Aux

DateTime ldh_Limite

String ls_MSG

//Conforme chamado 482005, se houver produto do fornecedor do parametro_geral $$HEX1$$e900$$ENDHEX$$ pra incluir a mensagem log$$HEX1$$ed00$$ENDHEX$$sitca

ldt_Aux = RelativeDate(Today(), 180)
ldh_Limite = DateTime("01/" + String(Month(ldt_Aux)) + "/" + String(Year(ldt_Aux)))

Insert Into pedido_central_prd_msg_logist(nr_pedido, cd_produto, cd_mensagem, dh_inclusao, nr_matricula_inclusao, dh_limite_validade)
Select p.nr_pedido, p.cd_produto, 2, getdate(), '14330', :ldh_Limite
From pedido_central_produto p
Where p.nr_pedido = :ivl_Pedido
	And Not Exists (Select *
						From pedido_central_prd_msg_logist x
						Where x.nr_pedido = p.nr_pedido
							And x.cd_mensagem = 2
							And x.cd_produto = p.cd_produto) 
	And p.cd_produto In (Select g.cd_produto
								From produto_geral g
								Where g.cd_produto = p.cd_produto
									And g.cd_fornecedor_usual = (Select vl_parametro
																			From parametro_geral
																			Where cd_parametro = 'FORENCEDOR_VAL_CURTA_EXCLU_BA'))
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro ao incluir a mensagem logistica no pedido exclusivo Bahia " + String(ivl_Pedido) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o of_msg_logistica_exclu_ba. " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	of_Grava_Log(ai_log, ls_MSG)
	Return False
End If

of_executa_commit()

Return True
end function

public function boolean of_limpa_divergencia_sap (string as_chave_acesso, ref string as_log);String ls_Erro

Delete from nf_agendamento_ent_item_diverg
where de_chave_acesso =:as_chave_acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	as_log = "Erro ao excluir os registros da tabela  [nf_agendamento_ent_item_diverg]: "+ ls_Erro
	Return False
End If	

Delete from nf_agendamento_ent_divergencia
where de_chave_acesso =:as_chave_acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	as_log = "Erro ao excluir os registros da tabela [nf_agendamento_ent_divergencia]: "+ ls_Erro
	Return False
End If	

SqlCa.of_Commit()

Return True
end function

public function boolean of_executa_commit ();// Comita somente se n$$HEX1$$e300$$ENDHEX$$o for iniciado a opera$$HEX2$$e700e300$$ENDHEX$$o SAP // SAP VAI COMMITAR NO FINAL
If Not ib_Iniciado_Operacao_SAP Then
	SqlCa.of_Commit()
End If

Return True
end function

private function boolean of_grava_divergencia (string as_divergencia, long al_tipo_divergencia, string as_de_produto, string as_cod_barras, ref string as_mensagem_log);dc_uo_transacao 	lo_SqlCa
Long ll_Divergencia, ll_Nr_Divergencia_2
Long ll_Nr_Divergencia, ll_Proximo_Seq
String ls_Divergencia
Date ldt_Atual
Long ll_Linha
Boolean lb_Ja_Tem = False
String ls_De_Produto
String ls_Mensagem_Div_Email

lo_SqlCa	= create dc_uo_transacao
lo_SqlCa.ivs_database = "SYBASE"
	
If lo_SqlCa.of_Connect("") Then
	
	If Not ib_Grava_Agendamento Then
		ls_Mensagem_Div_Email =  "EAN: " + as_cod_barras + "~r" + &
											"Produto: " + as_De_Produto + "~r" + &
											"Diverg$$HEX1$$ea00$$ENDHEX$$ncia: " + as_Divergencia + "~r~r"
	Else
		ls_Mensagem_Div_Email =  "<br><br>EAN: " + as_cod_barras + "<br>" + &
											"Produto: " + as_De_Produto + "<br>" + &
											"Diverg$$HEX1$$ea00$$ENDHEX$$ncia: " + as_Divergencia
	End If
	
	Choose Case al_Tipo_Divergencia
		Case 3 
			ls_Divergencia = "Produto com quantidade fracionada"
		Case 6  
			ls_Divergencia = "Nao foi localizado o codigo do produto com EAN do XML"
		Case 7  
			ls_Divergencia = "Produto esta sem o codigo de barras no XML"
		Case 8  
			ls_Divergencia = "Produto nao localizado no pedido"
		Case 9  
			ls_Divergencia = "Quantidade recebida maior do que quantidade pedida"
		Case 10  
			ls_Divergencia = "Situacao Tributaria incorreta"
		Case Else
			ls_Divergencia = as_Divergencia
	End Choose
		
	select nr_divergencia 
	Into :ll_Nr_Divergencia
	from pedido_central_divergencia 
	where cd_tipo_divergencia = :al_Tipo_Divergencia
	and de_divergencia = :ls_Divergencia
	and de_chave_acesso_nfe = :ivs_Chave_Acesso
	and nr_pedido = :ivl_Pedido
	Using lo_SqlCa;
	
	Choose Case lo_SqlCa.Sqlcode
		Case 0
			
		Case 100
			
			If Trim(as_De_Produto) <> "" Then
				//ivs_Divergencias[ UpperBound(ivs_Divergencias[])+1 ] = as_Divergencia +" Produto: "+as_De_Produto
				ivs_Divergencias[ UpperBound(ivs_Divergencias[])+1 ] = ls_Mensagem_Div_Email
			Else
				ivs_Divergencias[ UpperBound(ivs_Divergencias[])+1 ] = as_Divergencia
			End If
			
			ldt_Atual = Date(gf_GetServerDate())
			
			Select coalesce(max(nr_divergencia), 0) + 1
			Into :ll_Nr_Divergencia
			From pedido_central_divergencia
			Using lo_SqlCa;
			
			If  lo_SqlCa.Sqlcode = -1 Then
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da pr$$HEX1$$f300$$ENDHEX$$xima divergencia 'pedido_central_divergencia'. " + SqlCa.SqlErrText
				lo_SqlCa.of_Rollback()
				Return False	
			End If			
			
			insert into pedido_central_divergencia ( 
						  nr_divergencia,
						  cd_tipo_divergencia, 
						  de_divergencia, 
						  de_chave_acesso_nfe, 
						  nr_pedido, 
						  dh_divergencia) 
			values( 	:ll_Nr_Divergencia,
						:al_Tipo_Divergencia,
						:ls_Divergencia,
						:ivs_Chave_Acesso,
						:ivl_Pedido,
						:ldt_Atual)
			Using lo_SqlCa;
			
			If  lo_SqlCa.Sqlcode = -1 Then
				as_Mensagem_Log = "Insert na tabela 'pedido_central_divergencia'. " + SqlCa.SqlErrText
				lo_SqlCa.of_Rollback()
				Return False	
			End If
			
			select nr_divergencia 
			Into :ll_Nr_Divergencia
			from pedido_central_divergencia 
			where cd_tipo_divergencia = :al_Tipo_Divergencia
			and de_divergencia = :ls_Divergencia
			and de_chave_acesso_nfe = :ivs_Chave_Acesso
			and nr_pedido = :ivl_Pedido
			Using lo_SqlCa;
			
			If  lo_SqlCa.Sqlcode = -1 Then
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da tabela 'pedido_central_divergencia'. " + SqlCa.SqlErrText
				lo_SqlCa.of_Rollback()
				Return False	
			End If
			
		Case -1
			as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da tabela 'pedido_central_divergencia'. " + SqlCa.SqlErrText
			lo_SqlCa.of_Rollback()
			Return False
	End Choose						
	
	//12 $$HEX1$$e900$$ENDHEX$$ divergencia de pedido, 2 divergencia de fornecedor do pedido
	If (al_Tipo_Divergencia <> 12) and (al_Tipo_Divergencia <> 2) Then 
	
		ls_De_Produto = Mid(as_De_Produto, 1, 59)
		
		Select nr_divergencia
		Into :ll_Nr_Divergencia_2
		from pedido_central_divergencia_prd 
		Where  nr_divergencia 	= :ll_Nr_Divergencia
		and cd_tipo_divergencia = :al_Tipo_Divergencia
		and de_codigo_barras	= :as_Cod_Barras
		and de_divergencia		= :as_Divergencia
		and de_produto			= :ls_De_Produto
		Using lo_SqlCa;
		
		Choose Case lo_SqlCa.Sqlcode
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da tabela 'pedido_central_divergencia_prd'. " + SqlCa.SqlErrText
				lo_SqlCa.of_Rollback()
				Return False	
			Case 100	
				
				For ll_Linha = 1 To UpperBound(ivs_Divergencias[])
					//If ivs_Divergencias[ll_Linha] = as_Divergencia +" Produto: "+as_De_Produto	 Then
					If ivs_Divergencias[ll_Linha] = ls_Mensagem_Div_Email Then
						lb_Ja_Tem = True	
					End If
				Next
				
				If Not lb_Ja_Tem Then
					//ivs_Divergencias[ UpperBound(ivs_Divergencias[])+1 ] = as_Divergencia +" Produto: "+as_De_Produto
					ivs_Divergencias[ UpperBound(ivs_Divergencias[])+1 ] = ls_Mensagem_Div_Email
				End If
				
				Select coalesce(max(nr_sequencia), 0) + 1
				Into :ll_Proximo_Seq
				From pedido_central_divergencia_prd
				Where nr_divergencia = :ll_Nr_Divergencia
				Using lo_SqlCa;
				
				If  lo_SqlCa.Sqlcode = -1 Then
					as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo sequencial na tabela 'pedido_central_divergencia_prd'. " + SqlCa.SqlErrText
					lo_SqlCa.of_Rollback()
					Return False	
				End If				
				
				insert into pedido_central_divergencia_prd (	nr_divergencia, 
																		  	nr_sequencia,
																		  	cd_tipo_divergencia, 
									  									 	de_codigo_barras, 
									  									 	de_divergencia, 
									  										de_produto) 
				 values(	:ll_Nr_Divergencia, 
				 			:ll_Proximo_Seq, 
							:al_Tipo_Divergencia,  
							:as_Cod_Barras, 
							:as_Divergencia, 
							:ls_De_Produto)
				Using lo_SqlCa;						
									
				If  lo_SqlCa.Sqlcode = -1 Then
					as_Mensagem_Log = "Insert na tabela 'pedido_central_divergencia_prd'. " + SqlCa.SqlErrText
					lo_SqlCa.of_Rollback()
					Return False	
				End If
		End Choose
		
	End If		
	
	lo_SqlCa.of_Commit()
	
End If	 
	 
Destroy(lo_SqlCa)	 
	 
Return True
end function

public function boolean of_valida_quantidade_fracionada (long al_pedido, long al_produto, decimal adc_qt_produto, ref string as_mensagem_log, string as_chave_acesso, integer ai_item_nf, ref long al_caixa_padrao, ref string as_multiplicar_dividir);Decimal ldv_Qt_Produto
Long ll_Qt_Produto

If Not of_Calcula_Caixa_Padrao(al_pedido, al_produto,  adc_qt_produto, Ref ldv_Qt_Produto, Ref as_Mensagem_Log, as_chave_acesso, ai_item_nf, ref al_caixa_padrao, ref as_multiplicar_dividir) Then
	Return False	
End If

ll_Qt_Produto = Long(ldv_Qt_Produto)

//Verifica se a quantidade $$HEX1$$e900$$ENDHEX$$ fracionada
ldv_Qt_Produto =  ldv_Qt_Produto + 1.00 //Colocado "+ 1.00" para quando a quantidade for zero n$$HEX1$$e300$$ENDHEX$$o ocorrer erro na divis$$HEX1$$e300$$ENDHEX$$o
If Not ((ldv_Qt_Produto / Long(ldv_Qt_Produto)) = 1) Then
	If Not of_grava_divergencia("Produto est$$HEX1$$e100$$ENDHEX$$ com a quantidade fracionada.", 3, "", String(al_Produto), Ref as_Mensagem_Log, as_chave_acesso,  ai_item_nf) Then
		Return False
	End If
End If

Return True
end function

public function boolean of_fecha_conexao_log ();//Fecha conex$$HEX1$$e300$$ENDHEX$$o usada para gerar log.
if isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log.of_disconnect( )
	destroy(iuo_SqlCa_log)
end if

return true
end function

public function boolean of_abre_conexao_log (ref string ps_log);///Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
if Not isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log = create dc_uo_transacao
	iuo_SqlCa_log.ivs_database = "SYBASE"
end if

if Not iuo_SqlCa_log.of_isconnected() Then

	If Not iuo_SqlCa_log.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GN - Importa$$HEX2$$e700e300$$ENDHEX$$o NF') Then
		ps_log =  'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_abre_conexao_log ~n' + "Erro ao conectar no Sybase."
		Return False
	End If
	
end if

return true
end function

private function boolean of_grava_log_receb_sap (string as_log, integer ai_item_xml, ref string as_log_ret);If IsNull(is_Recebimento_SAP) Then Return True

try
	If Not This.of_abre_conexao_log(ref as_log) Then Return False
	
	If ai_item_xml = 0 Then SetNull(ai_item_xml)
	
	as_log = Upper(as_log)
	
	INSERT INTO recebimento_sap_log ( nr_recebimento, nr_item, de_log )  
  	VALUES (:is_Recebimento_SAP,  :ai_item_xml, :as_log)
   	Using iuo_SqlCa_log;
		
	If iuo_SqlCa_log.SqlCode = -1 Then
		as_log_ret = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do log [RECEBIMENTO_SAP_LOG]. " + SqlCa.SqlErrText
		iuo_SqlCa_log.of_Rollback()
		Return False	
	End If
	
	update recebimento_sap
	set id_situacao = 'E'
	where nr_recebimento = :is_Recebimento_SAP
	Using iuo_SqlCa_log;
	
	If iuo_SqlCa_log.SqlCode = -1 Then
		as_log_ret = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do log [RECEBIMENTO_SAP_LOG]. " + SqlCa.SqlErrText
		iuo_SqlCa_log.of_Rollback()
		Return False	
	End If	
	
	iuo_SqlCa_log.of_Commit();	
finally

end try
 
Return True
end function

public function boolean of_calcula_caixa_padrao (long al_pedido, long al_produto, decimal adc_quantidade, ref decimal adc_qtde_calculada, ref string as_mensagem_log, string as_chave_acesso, integer ai_sequencial_item_xml, ref long al_caixa_padrao, ref string as_multiplicar_dividir);Long ll_Caixa_Padrao
Long ll_Qt_Produto
Long ll_Produto_Receb_SAP
Long ll_Qtde_Receb_SAP

String ls_Multip_Dividir

Boolean lb_Tem_Caixa_Padrao = False

Decimal ldv_Qt_Produto

try 
	If ib_Iniciado_Operacao_SAP Then
	
		If IsNull(is_Recebimento_SAP) Then
			as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi informado n$$HEX1$$fa00$$ENDHEX$$mero do recebimento do SAP."
			This.of_grava_log_receb_sap(as_Mensagem_Log, 0, ref as_Mensagem_Log)
			Return False
		End If
	
		SELECT
			rsi.cd_produto, 
			rsi.qt_recebida
		INTO 
			:ll_Produto_Receb_SAP, 
			:ll_Qtde_Receb_SAP
		FROM
			recebimento_sap rs
		INNER JOIN
			recebimento_sap_item rsi
			ON rsi.nr_recebimento = rs.nr_recebimento
		WHERE 
			rs.nr_recebimento = :is_Recebimento_SAP
			AND rs.de_chave_acesso 	= :as_chave_acesso
			AND coalesce(rsi.nr_item_xml, 0)	= :ai_sequencial_item_xml
		USING
			SqlCa;
		
		Choose Case SqlCa.Sqlcode
			Case 0
				if ll_Qtde_Receb_SAP <= 0 then
					as_Mensagem_Log = "A quantidade informada no recebimento SAP [" + String(ll_Qtde_Receb_SAP) + "] est$$HEX1$$e100$$ENDHEX$$ zerada."
					This.of_grava_log_receb_sap(as_Mensagem_Log, ai_sequencial_item_xml, ref as_Mensagem_Log)
					Return False
				elseif ll_Qtde_Receb_SAP = adc_quantidade Then
					al_caixa_padrao 		= 1
					as_multiplicar_dividir 	= 'M'
				Else
					// Verifica se as quantidades do recebimento e faturada do XML s$$HEX1$$e300$$ENDHEX$$o divis$$HEX1$$ed00$$ENDHEX$$veis
					If iif(ll_Qtde_Receb_SAP > adc_quantidade, Mod(ll_Qtde_Receb_SAP, adc_quantidade), Mod(adc_quantidade, ll_Qtde_Receb_SAP)) <> 0 Then 
						as_Mensagem_Log = "A quantidade informada no recebimento SAP [" + String(ll_Qtde_Receb_SAP) + "] n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ divis$$HEX1$$ed00$$ENDHEX$$vel pela quantidade faturada no XML [" + String(adc_quantidade) + "]."
						This.of_grava_log_receb_sap(as_Mensagem_Log, ai_sequencial_item_xml, ref as_Mensagem_Log)
						Return False
					End If
					
					If ll_Qtde_Receb_SAP > adc_quantidade Then
						ls_Multip_Dividir 		= 'M'
						ll_Caixa_Padrao 		= long(ll_Qtde_Receb_SAP / adc_quantidade)
					Else
						ls_Multip_Dividir 		= 'D'
						ll_Caixa_Padrao 		=  long(adc_quantidade / ll_Qtde_Receb_SAP)
					End If
					
					al_caixa_padrao 		= ll_Caixa_Padrao
					as_multiplicar_dividir 	= ls_Multip_Dividir
					
					lb_Tem_Caixa_Padrao 	= True
				End If
			
			Case 100
				as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi informada a quantidade recebida no SAP."
				This.of_grava_log_receb_sap(as_Mensagem_Log, ai_sequencial_item_xml, ref as_Mensagem_Log)
				Return False
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade recebida do SAP. " + SqlCa.SqlErrText
				This.of_grava_log_receb_sap(as_Mensagem_Log, ai_sequencial_item_xml, ref as_Mensagem_Log)
				Return False
		End Choose

	Else
	
		select top 1 qt_caixa_padrao, id_multiplicar_dividir
		Into :ll_Caixa_Padrao, :ls_Multip_Dividir
		from produto_caixa_padrao_forn
		where cd_fornecedor = (select cd_fornecedor from pedido_central where nr_pedido = :al_Pedido)
		and cd_produto = :al_produto
		order by dh_alteracao desc
		Using SqlCa;
		
		Choose Case SqlCa.Sqlcode
			Case 0
				lb_Tem_Caixa_Padrao = True
			Case -1
				as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da caixa padr$$HEX1$$e300$$ENDHEX$$o do produto. " + SqlCa.SqlErrText
				Return False
		End Choose
	
	End If

	If lb_Tem_Caixa_Padrao Then
		
		If ls_Multip_Dividir = "M"	 Then
			adc_qtde_calculada = adc_quantidade	* ll_Caixa_Padrao
		Else
			adc_qtde_calculada = adc_quantidade	/ ll_Caixa_Padrao
		End If
				
		UPDATE nf_agendamento_ent_item  
			SET  qt_caixa_padrao = :ll_Caixa_Padrao, id_multiplic_dividir_cx_padrao = :ls_Multip_Dividir, nr_recebimento_sap = :is_Recebimento_SAP
		Where de_chave_acesso	= :as_chave_acesso 
			 and cd_produto 		= :al_produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Mensagem_Log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da caixa padr$$HEX1$$e300$$ENDHEX$$o do produto na tabela nf_agendamento_ent_item. " + SqlCa.SqlErrText
			SqlCa.of_RollBack()
			Return False
		End If
			
	Else
		
		UPDATE nf_agendamento_ent_item  
			SET  qt_caixa_padrao = null, id_multiplic_dividir_cx_padrao = null, nr_recebimento_sap = :is_Recebimento_SAP
		Where de_chave_acesso 	= :as_chave_acesso 
			  and cd_produto			= :al_produto
			 and qt_caixa_padrao 	is not null
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Mensagem_Log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da caixa padr$$HEX1$$e300$$ENDHEX$$o do produto na tabela nf_agendamento_ent_item. " + SqlCa.SqlErrText
			SqlCa.of_RollBack()
			Return False
		End If
			
		adc_qtde_calculada = adc_quantidade
	End If
	
catch ( runtimeerror  lo_rte )
	as_mensagem_log = "of_calcula_caixa_padrao - Erro: "+ lo_rte.GetMessage()
finally
	/*statementBlock*/
end try

Return True
end function

public function boolean of_verifica_excecao_regra (long al_produto, string as_fornecedor, ref long al_excecao, ref string as_log);select 1
  into :al_excecao
  from produto_excecao_regra_gn
 where cd_produto			= :al_produto and
 		 cd_fornecedor		= :as_fornecedor and
		 dh_valido_desde 	<= getdate();

Choose case sqlca.SqlCode
	case -1
		as_log	= 'Erro ao buscar registro da tabela produto_excecao_regra_gn. Erro: ' + String(sqlca.sqlerrtext)
		return false
	case 100
		al_excecao	= 0
		return true
	case 0
		al_excecao	= 1
		return true
end choose
end function

public function boolean of_localiza_parametros (ref string as_mensagem_log);Decimal lvs_percentual

Select vl_parametro
Into :lvs_percentual
From parametro_geral
where cd_parametro = 'PC_LIMITE_DIVERGENCIA_AGENDAMENTO'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvs_percentual) Then 
			il_Percentual_Limite_Divergencia	 = Long (lvs_percentual) 
		Else
			as_mensagem_log = "Parametro: PC_LIMITE_DIVERGENCIA_AGENDAMENTO sem valor definido"
			Return False
		End If 
	Case -1
		as_mensagem_log = "Erro na consulta do vl_parametro para parametro PC_LIMITE_DIVERGENCIA_AGENDAMENTO:" + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_nosso_codigo_produto_distrib (string as_fornecedor, long al_produto, ref string as_mensagem_log, ref long al_qt_embalagem_padrao_distrib);Long 	ll_Achou

Select Count(*)
	Into :ll_Achou
From distribuidora_produto
Where cd_distribuidora = :as_Fornecedor
	And cd_unidade_federacao = 'SC'
	And cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto " + String(al_Produto) + " na distribuidora " + as_Fornecedor + "."
	Return False
End If

If ll_Achou > 0 Then
	Select coalesce(qt_embalagem_padrao_distrib, 1) 
	  Into :al_qt_embalagem_padrao_distrib
	  From distribuidora_produto
	 Where cd_distribuidora = :as_Fornecedor
		And cd_unidade_federacao = 'SC'
		And cd_produto = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade de embalagem do produto " + String(al_Produto) + " na distribuidora " + as_Fornecedor + "."
		Return False
	End If
	
	if IsNull(al_qt_embalagem_padrao_distrib) then al_qt_embalagem_padrao_distrib = 1

	Return True
Else
	as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o relacionamento do produto " + String(al_Produto) + " na distribuidora " + as_Fornecedor + "."
	Return False
End If
end function

public function boolean of_insere_nf_agendamento (t_infnfe a_infnfe, string as_chave_acesso, ref string as_mensagem_log, ref string as_mensagem_pbm, long al_filial, ref boolean ab_envio_email);Double	ld_Vl_Bc_Icms,&
			ld_Vl_ICMS,&
			ld_Vl_Bc_Icms_St,&
			ld_Vl_Icms_St,&
			ld_Vl_Total_Produtos,&
			ld_Vl_Ipi,&
			ld_Vl_Frete,&
			ld_Vl_Seguro,&
			ld_Vl_Outras_Despesas,&
			ld_Vl_Desconto,&
			ld_Vl_Total_Nf
			
String	ls_Achou,&
		ls_NatOp,&
		ls_CNPJ_For,&
		ls_Dados_Adicionais,&
		ls_Razao_Social,&
		ls_ModFrete, &
		ls_refnfe

Date ldt_Emissao

Long	ll_Volumes,&
		ll_Ocorrencia,&
		ll_Ocorrencias
		
DateTime ldt_Recebido_Sap

Double	ld_vl_total_is, ld_vl_total_bc_cbs_ibs, &
			ld_vl_total_dif_ibs_uf, ld_vl_total_dev_ibs_uf, ld_vl_total_ibs_uf, ld_vl_total_dif_ibs_mun, ld_vl_total_dev_ibs_mun, &
			ld_vl_total_ibs_mun, ld_vl_total_ibs, ld_vl_total_dif_cbs, ld_vl_total_dev_cbs, ld_vl_total_cbs

ld_Vl_Bc_Icms 						= a_infnfe.total.ICMSTot.vBC
ld_Vl_ICMS 							= a_infnfe.total.ICMSTot.vICMS
ld_Vl_Bc_Icms_St 					= a_infnfe.total.ICMSTot.vBCST
ld_Vl_Icms_St 						= a_infnfe.total.ICMSTot.vST
//ld_Vl_Total_Produtos 			= Round((a_infnfe.total.ICMSTot.vProd - (a_infnfe.total.ICMSTot.vDesc + a_infnfe.total.ICMSTot.vICMSDeson)), 2)
ld_Vl_Total_Produtos 			= Round((a_infnfe.total.ICMSTot.vProd - a_infnfe.total.ICMSTot.vDesc), 2)

ld_Vl_Ipi 							= a_infnfe.total.ICMSTot.vIPI
ld_Vl_Frete 						= a_infnfe.total.ICMSTot.vFrete
ld_Vl_Seguro 						= a_infnfe.total.ICMSTot.vSeg
ld_Vl_Outras_Despesas 			= a_infnfe.total.ICMSTot.vOutro
ld_Vl_Desconto 					= 0
ld_Vl_Total_Nf 					= a_infnfe.total.ICMSTot.vNF

il_Nota 					= 	a_infnfe.ide.nnf
is_Especie				= 	'NFE'
is_Serie					= 	a_infnfe.ide.serie
ls_NatOp					=	a_infnfe.ide.natop
ldt_Emissao				= 	a_infnfe.ide.demi
ls_CNPJ_For				= 	a_infnfe.emit.cnpj
ls_Razao_Social		= 	a_infnfe.emit.xnome

if Upperbound(a_infnfe.ide.nfref.refnfe) > 0 then
	ls_refnfe				= a_infnfe.ide.nfref.refnfe[1]
else
	SetNull(ls_refnfe)
end if

ls_Dados_Adicionais 	=  a_infnfe.infadic.infadfisco
ls_Dados_Adicionais 	+=  a_infnfe.infadic.infcpl

ll_Volumes				= 0

ls_ModFrete 			= 	String(a_infnfe.transp.modfrete)

ll_Ocorrencias			= UpperBound(a_infnfe.transp.vol[])

ld_vl_total_is						= a_infnfe.total.istot.vis
ld_vl_total_bc_cbs_ibs			= a_infnfe.total.IBSCBSTot.vBCIBSCBS
ld_vl_total_dif_ibs_uf			= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vDif
ld_vl_total_dev_ibs_uf			= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vDevTrib
ld_vl_total_ibs_uf				= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vIBSUF
ld_vl_total_dif_ibs_mun			= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vDif
ld_vl_total_dev_ibs_mun			= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vDevTrib
ld_vl_total_ibs_mun				= a_infnfe.total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vIBSMun
ld_vl_total_ibs					= a_infnfe.total.IBSCBSTot.gIBS_tot.vIBS
ld_vl_total_dif_cbs				= a_infnfe.total.IBSCBSTot.gCBS_tot.vDif
ld_vl_total_dev_cbs				= a_infnfe.total.IBSCBSTot.gCBS_tot.vDevTrib
ld_vl_total_cbs					= a_infnfe.total.IBSCBSTot.gCBS_tot.vCBS

If ll_Ocorrencias > 0 Then
	For ll_Ocorrencia = 1 To ll_Ocorrencias
		ll_Volumes += a_infnfe.transp.vol[ll_Ocorrencia].qVol	
	Next
End If

//****************************
// OLHAR DESONERA$$HEX2$$c700c300$$ENDHEX$$O -> Obs.: A desonera$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ nos itens da nota
//****************************

SetNull(ivl_Pedido)
SetNull(ldt_Recebido_Sap)

If ib_Iniciado_Operacao_SAP Then
	ldt_Recebido_Sap = gf_GetServerDate()
End If

SELECT de_chave_acesso  
  INTO :ls_Achou  
  FROM nf_agendamento_ent
 Where de_chave_acesso = :as_chave_acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		INSERT INTO nf_agendamento_ent	( 
			de_chave_acesso,   
			nr_nf,   
			de_especie,   
			de_serie,   
			de_natureza_operacao,   
			nr_cgc_fornecedor,   
			dh_emissao,   
			vl_bc_icms,   
			vl_icms,   
			vl_bc_icms_st,   
			vl_icms_st,   
			vl_total_produtos,   
			vl_ipi,   
			vl_frete,   
			vl_seguro,   
			vl_outras_despesas,   
			vl_desconto,   
			vl_total_nf,   
			nr_pedido_central,   
			dh_inclusao,   
			dh_liberacao_agendamento,   
			nr_matricula_lib_agendamento,   
			de_retorno_webservice,   
			de_dados_adicionais,
			qt_volumes,
			nm_razao_social,
			id_modalidade_frete,
			dh_recebido_sap,
			de_chave_acesso_nf_ref,
			vl_total_bc_cbs_ibs,
			vl_total_dif_ibs_uf,
			vl_total_dev_ibs_uf,
			vl_total_ibs_uf,
			vl_total_dif_ibs_mun,
			vl_total_dev_ibs_mun,
			vl_total_ibs_mun,
			vl_total_ibs,
			vl_total_dif_cbs,
			vl_total_dev_cbs,
			vl_total_cbs)  
		VALUES ( 	
			:as_chave_acesso,				//de_chave_acesso,   
			:il_Nota,						//nf_nf,   
			:is_Especie,					//de_especie,   
			:is_Serie,						//de_serie,   
			:ls_NatOp,						//de_natureza_operacao,   
			:ls_CNPJ_For,					//nr_cgc_fornecedor,   
			:ldt_Emissao,					//dh_emissao,   
			:ld_Vl_Bc_Icms,				//vl_bc_icms,   
			:ld_Vl_ICMS,					//vl_icms,   
			:ld_Vl_Bc_Icms_St,			//vl_bc_icms_st,   
			:ld_Vl_Icms_St,				//vl_icms_st,   
			:ld_Vl_Total_Produtos,		//vl_total_produtos,   
			:ld_Vl_Ipi,						//vl_ipi,   
			:ld_Vl_Frete,					//vl_frete,   
			:ld_Vl_Seguro,					//vl_seguro,   
			:ld_Vl_Outras_Despesas,		//vl_outras_despesas,   
			:ld_Vl_Desconto,				//vl_desconto,   
			:ld_Vl_Total_Nf,				//vl_total_nf,   
			:ivl_Pedido,					//nr_pedido_central,   
			getdate(),						//dh_inclusao,   
			null,								//dh_liberacao_agendamento,   
			null,								//nr_matricula_lib_agendamento,   
			null,								//de_retorno_webservice,   
			:ls_Dados_Adicionais,		//de_dados_adicionais 
			:ll_Volumes,					//qt_volumes
			:ls_Razao_Social,				//nm_razao_social
			:ls_ModFrete,					//id_modalidade_frete
			:ldt_Recebido_Sap,		   //ldt_Recebido_Sap
			:ls_refnfe,						//de_chave_acesso_nf_remessa
			:ld_vl_total_bc_cbs_ibs,
			:ld_vl_total_dif_ibs_uf,
			:ld_vl_total_dev_ibs_uf,
			:ld_vl_total_ibs_uf,
			:ld_vl_total_dif_ibs_mun,
			:ld_vl_total_dev_ibs_mun,
			:ld_vl_total_ibs_mun,
			:ld_vl_total_ibs,
			:ld_vl_total_dif_cbs,
			:ld_vl_total_dev_cbs,
			:ld_vl_total_cbs)
		Using SqlCa;
					
		If SqlCa.SqlCode = -1 Then
			as_Mensagem_Log = "Erro ao incluir a nota [nf_agendamento_ent]: "+ SqlCa.sqlerrtext
			SqlCa.of_RollBack();
			Return False
		End If
	Case -1
		as_Mensagem_Log = "Erro ao localizar a nota [nf_agendamento_ent]: "+ SqlCa.sqlerrtext
		SqlCa.of_RollBack();
		Return False
End Choose

If Not This.of_valida_pedido(as_chave_acesso, ls_CNPJ_For, ldt_Emissao, ref as_mensagem_log,  al_filial, ref ab_envio_email  ) Then Return False
		
If Not IsNull(ivl_Pedido) Then
	UPDATE nf_agendamento_ent  
	SET nr_pedido_central = :ivl_Pedido
	Where de_chave_acesso = :as_chave_acesso
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Mensagem_Log = "Erro ao atualizar a nota [nf_agendamento_ent]: "+ SqlCa.sqlerrtext
		SqlCa.of_RollBack();
		Return False
	End If
End If

Return True

end function

public function boolean of_valida_pedido (string as_chave_acesso, string as_cnpj, date adt_emissao_nf, ref string as_mensagem_log, long al_filial, ref boolean ab_envio_email);Long ll_Achou

SetNull(ivl_Pedido)
ab_envio_email = True 

If al_filial = 534  and   IsNull(il_Pedido_Interface_SAP) Then 
	ab_envio_email = False
	as_mensagem_log = 'Sem Registro na tabela [RECEBIMENTO_SAP].Chave:'+String(as_chave_acesso)
	Return False
End If 	

If IsNull(il_Pedido_Interface_SAP) Then
	as_mensagem_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informado o pedido na tabela [RECEBIMENTO_SAP].'
	This.of_grava_divergencia_agend(as_mensagem_log, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 )
	Return False
End If

select nr_pedido
Into :ll_Achou
from pedido_central
where nr_pedido = :il_Pedido_Interface_SAP
and cd_filial = 534
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 0
	Case 100
		as_mensagem_log = "O pedido informado na tabela [RECEBIMENTO_SAP]  '" + String(il_Pedido_Interface_SAP) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela [PEDIDO_CENTRAL]."
		This.of_grava_divergencia_agend(as_mensagem_log, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 )
		Return False
	Case -1
		as_Mensagem_Log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido '"+String(il_Pedido_Interface_SAP)+"' na tabela 'pedido_central'. " + SqlCa.SqlErrText
		Return False
End Choose

If Not This.of_Valida_Pedido_Ativo(il_Pedido_Interface_SAP, Ref as_mensagem_log) Then
	This.of_grava_divergencia_agend(as_mensagem_log, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 )
	Return False
End If

If Not of_Valida_Cnpj_Pedido(as_cnpj, il_Pedido_Interface_SAP, Ref as_Mensagem_Log) Then
	This.of_grava_divergencia_agend(as_mensagem_log, 2, "", "", Ref as_mensagem_log, as_chave_acesso, 0 )
	Return False
End If

If Not This.of_Valida_Data_Emissao_Pedido(il_Pedido_Interface_SAP, adt_Emissao_Nf, Ref as_mensagem_log) Then
	This.of_grava_divergencia_agend(as_mensagem_log, 12, "", "", Ref as_mensagem_log, as_chave_acesso, 0 )
	Return False
End If

ivl_Pedido = il_Pedido_Interface_SAP

Return True
end function

public function boolean of_valida_preco_produto (long al_pedido, long al_produto, string as_de_produto, string as_ean, decimal adc_preco_unitario, decimal adc_pc_desconto, decimal adc_vl_icms_deson_unit, string as_chave_acesso, long al_embalagem_padrao, string as_dividir_multiplicar, long al_indice, date adt_recebido_sap, ref string as_mensagem);Decimal	ldc_Preco_Unitario_Pedido,&
			ldc_Pc_Desconto_Produto,&
			ldc_Pc_Desconto_Pedido,&
			ldc_Diferenca,&
			ldc_Preco_Unitario_Nota, &
			ldc_diferenca_valor
			
String	ls_Mensagem

Boolean	lb_Vl_Nota_Menor_Vl_Pedido, lb_retirou_desonerado = False

// Chamado 1184586
If Not of_localiza_parametros( Ref as_mensagem ) Then Return False

//if not IsNull(adt_recebido_sap) then
//	return true
//end if

Select round((((b.vl_preco_unitario * ((100 - b.pc_desconto) / 100)) * ((100 - a.pc_desconto) / 100)) * ((100 - b.pc_repasse_icms) / 100)),2)
Into :ldc_Preco_Unitario_Pedido
From pedido_central a
inner join pedido_central_produto b on b.nr_pedido = a.nr_pedido
Where	a.nr_pedido	= :al_Pedido
	And	b.cd_produto	= :al_Produto
Using SqlCa;	

Choose Case SqlCa.Sqlcode
	Case 0
		If ldc_Preco_Unitario_Pedido = 0.00 Then
			ls_Mensagem	= "Produto com pre$$HEX1$$e700$$ENDHEX$$o de compras zerado no pedido."
			If Not of_grava_divergencia(ls_Mensagem, 1000, as_De_Produto, as_Ean, Ref as_Mensagem, as_chave_acesso, al_indice ) Then
				Return False
			End If
		Else
			lb_retirou_desonerado	= False
			
			CalculoDeson:
			
			ldc_Preco_Unitario_Nota	= Round((adc_preco_unitario * ((100 - adc_Pc_Desconto) / 100)) - adc_vl_icms_deson_unit, 2)
			
			If as_Dividir_Multiplicar = "D" Then
				ldc_Preco_Unitario_Nota = Round(ldc_Preco_Unitario_Nota * al_Embalagem_padrao, 2)
			Else
				ldc_Preco_Unitario_Nota = Round(ldc_Preco_Unitario_Nota / al_Embalagem_padrao, 2)
			End If
			
			If ldc_Preco_Unitario_Nota > 0.00 Then
				If ldc_Preco_Unitario_Pedido < ldc_Preco_Unitario_Nota Then
					ldc_diferenca_valor	= ldc_Preco_Unitario_Nota - ldc_Preco_Unitario_Pedido
					
					if ldc_diferenca_valor > 0.01 then
						ldc_Diferenca = Round((ldc_diferenca_valor / ldc_Preco_Unitario_Pedido) * 100, 2)
					else
						ldc_Diferenca = 0
					end if
					
					lb_Vl_Nota_Menor_Vl_Pedido = False
				Else
					ldc_diferenca_valor	= ldc_Preco_Unitario_Pedido - ldc_Preco_Unitario_Nota
					
					if ldc_diferenca_valor > 0.01 then
						ldc_Diferenca = Round((ldc_diferenca_valor / ldc_Preco_Unitario_Nota) * 100, 2)
					else
						ldc_Diferenca = 0
					end if
					
					lb_Vl_Nota_Menor_Vl_Pedido = True
				End If
				
				if (ldc_Diferenca < (il_Percentual_Limite_Divergencia * -1) or ldc_Diferenca > il_Percentual_Limite_Divergencia) and not lb_retirou_desonerado and adc_vl_icms_deson_unit > 0 then
					adc_vl_icms_deson_unit	= 0
					
					lb_retirou_desonerado	= True
					
					Goto CalculoDeson
				end if
				
			    // Colocado o Percentual em Parametro: PC_LIMITE_DIVERGENCIA_AGENDAMENTO
				If ldc_Diferenca > il_Percentual_Limite_Divergencia   Then 
					If lb_Vl_Nota_Menor_Vl_Pedido Then
						ls_Mensagem	= "Produto com pre$$HEX1$$e700$$ENDHEX$$o menor do que o pedido. Diferen$$HEX1$$e700$$ENDHEX$$a maior do que " + String(il_Percentual_Limite_Divergencia) + "%."
						If Not of_grava_divergencia(ls_Mensagem, 1000, as_De_Produto, as_Ean, Ref as_Mensagem, as_chave_acesso, al_indice ) Then
							Return False
						End If
					Else
						ls_Mensagem	= "Produto com diferen$$HEX1$$e700$$ENDHEX$$a de pre$$HEX1$$e700$$ENDHEX$$o maior do que " +String(il_Percentual_Limite_Divergencia) +"% em rela$$HEX2$$e700e300$$ENDHEX$$o ao pedido."
						If Not of_grava_divergencia(ls_Mensagem, 1, as_De_Produto, as_Ean, Ref as_Mensagem, as_chave_acesso, al_indice ) Then
							Return False
						End If
					End If
				End If
			End If
		End If
	Case 100
	Case -1
		as_mensagem = "Localiza o pre$$HEX1$$e700$$ENDHEX$$o do produto no pedido'. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_verifica_liberacao_agendamento (string as_chave_acesso, ref boolean ab_liberado, ref string as_log);DateTime	ldt_dh_liberacao_agendamento, ldt_dh_atual
Long		ll_diferenca_dias


select dh_liberacao_agendamento
  into :ldt_dh_liberacao_agendamento
  from nf_agendamento_ent
 where de_chave_acesso	= :as_chave_acesso
Using SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao buscar data de libera$$HEX2$$e700e300$$ENDHEX$$o do agendamento. ~r~rErro: ' + SQLCA.SQLErrText
		Return False
End Choose

ldt_dh_atual = gf_getserverdate()

if IsNull(ldt_dh_liberacao_agendamento) or Date(ldt_dh_liberacao_agendamento) = Date('1900-01-01') then
	ab_liberado = false
	Return True
end if

ll_diferenca_dias	= DaysAfter (Date(ldt_dh_liberacao_agendamento), Date(ldt_dh_atual))

if ll_diferenca_dias <= 30 then
	ab_liberado = true
	Return True
end if

as_log		= 'A libera$$HEX2$$e700e300$$ENDHEX$$o foi feita a mais de 30 dias. Necess$$HEX1$$e100$$ENDHEX$$rio revis$$HEX1$$e300$$ENDHEX$$o da nota fiscal.'
ab_liberado	= False

Return False

end function

public function boolean of_verifica_divergencias (string as_chave_acesso, date adt_emissao, long al_pedido, long al_filial, string as_diretorio_xml, ref string as_mensagem_log, ref string as_mensagem_pbm, integer ai_log, string as_index_destinadas, boolean ab_iniciado_operacao_sap, string as_recebimento_sap, ref boolean ab_envio_email, ref string as_resolvido, ref datetime adt_resolvido);dc_uo_nfe lo_NFE

t_infnfe lt_InfNFe

Boolean	lb_Retorno = True,&
			lb_Sucesso = True,&
			lb_Erro, &
			lb_agendamento_liberado	= False

Integer li_FileOpen

Long ll_Pedido_PBM

String	ls_Xml,&
			ls_Diretorio_Xml,&
			ls_Log_Validacao,&
			ls_nat_operacao,&
			ls_Mensagem_Log,&
			ls_Null[],&
			ls_CNPJ_For,&
			ls_Chave_Acesso_file, &
			ls_Erro

ib_marca_verificado_divergencia_ped = True //Marca o id_verificado_divergencia_ped para n$$HEX1$$e300$$ENDHEX$$o validar o XML novamente
ib_Envia_Email_Fiscal = False

str = str_Limpar
ib_Pedido_Ba = False //Pedidos de produtos exclusivos da Bahia para o Estoque Central

ib_Diverg_Ped_Trocado = False

// Aqui vem o NR_PEDIDO que fica na tabela RECEBIMENTO_SAP, recebido via interface depois que a nota $$HEX1$$e900$$ENDHEX$$ homologada no GRC (SAP)
il_Pedido_Interface_SAP = al_pedido

ib_Iniciado_Operacao_SAP 	= ab_iniciado_operacao_sap
is_Recebimento_SAP 			= as_recebimento_sap

ib_valida_teste_integrado	= gf_valida_teste_integrado()

Try
	if ib_valida_teste_integrado then
		if isNull(as_Chave_Acesso) then
			Return False
		End If
		
		select de_chave_acesso_alterada
		  into :ls_Chave_Acesso_file
		  from recebimento_sap
		 where de_chave_acesso = :as_Chave_Acesso
		using SQLCA;
		
		lb_erro	= False
		
		Choose Case SQLCA.SQLCode
			Case -1
				as_Mensagem_Log	= 'Erro ao localizar a chave de acesso do recebimento SAP. ' + SQLCA.SQLErrText
				lb_Retorno	= False
			Case 100
				as_Mensagem_Log	= 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a chave de acesso do recebimento SAP.'
				lb_Retorno	= False
		End Choose
				
		if Not lb_Retorno then
			Return False
		End If
		
		if IsNull(ls_Chave_Acesso_file) then
			Return False
		End If
	else
		ls_Chave_Acesso_file	= as_Chave_Acesso
	end if
	
	if not of_verifica_liberacao_agendamento(ls_chave_acesso_file, REF lb_agendamento_liberado, REF ls_mensagem_log) then
		lb_Retorno = False
		Return False
	end if
	
	If of_Nota_Ja_Importada(ls_Chave_Acesso_file, Ref ls_Mensagem_Log) Then
		as_Mensagem_Log = ls_Mensagem_Log
		 lb_Retorno = False
		Return False	
	End If

	If of_Pedido_PBM_Ja_Incluso(ls_Chave_Acesso_file, Ref ls_Mensagem_Log) Then
	  	as_Mensagem_Log = ls_Mensagem_Log
		lb_Retorno = False
		Return False	
	End If	
	
	If ib_Iniciado_Operacao_SAP Then
		If Not This.of_limpa_divergencia_sap(ls_Chave_Acesso_file, Ref ls_Mensagem_Log) Then 
			as_Mensagem_Log = ls_Mensagem_Log
			 lb_Retorno = False
			Return False	
		End If
	End If
	
	ivs_Divergencias[]								= ls_Null[]
	ivs_Divergencias_Agend[]					= ls_Null[]
	ivs_Divergencias_Agend_Nao_Fornec[]	= ls_Null[]
	
	ls_Diretorio_Xml = as_Diretorio_Xml + ls_Chave_Acesso_file+"-nfe.xml"
	
	// Todos os XML'S s$$HEX1$$e300$$ENDHEX$$o baixados da area FTP no inicio do processo, caso n$$HEX1$$e300$$ENDHEX$$o seja encontrado faz a busca no SEFAZ e neste caso precisa tentar baixar da area FTP novamente
	If Not FileExists(ls_Diretorio_Xml) Then
		If not of_Busca_Xml_Ftp(as_Chave_Acesso, adt_Emissao, al_Filial, as_Diretorio_Xml, Ref ls_Mensagem_Log) Then
			as_Mensagem_Log = ls_Mensagem_Log
			ib_marca_verificado_divergencia_ped = False 
			lb_Retorno = False
			Return False
		End If
	End If
			
	If Not FileExists(ls_Diretorio_Xml) Then
		//as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o arquivo: "+ ls_Diretorio_Xml
		as_Mensagem_Log = "O XML n$$HEX1$$e300$$ENDHEX$$o foi localizado na $$HEX1$$e100$$ENDHEX$$rea FTP."
		ib_marca_verificado_divergencia_ped = False 
		lb_Retorno = False
		Return False	
	End If
	
	If FileLength(ls_Diretorio_Xml) < 1 Then
		as_Mensagem_Log = "Tamanho do arquivo: "+ ls_Diretorio_Xml +" $$HEX1$$e900$$ENDHEX$$ 0 byte"
		ib_marca_verificado_divergencia_ped = False 
		lb_Retorno = False
		Return False	
	End If
	
	li_FileOpen = FileOpen (ls_Diretorio_Xml , TextMode! , Read!, LockRead!)
	FileReadEx (li_FileOpen, ls_Xml) 
	FileClose (li_FileOpen)
	
	If ls_Xml <> "" Then
		
		Try
			lo_NFE = Create dc_uo_nfe
			If Not lo_NFE.of_read_xml(ls_Xml, True, Ref lt_InfNFe) Then
				as_Mensagem_Log = " Erro ao ler o arquivo XML"
				ib_marca_verificado_divergencia_ped = False 
				lb_Retorno = False
				Return False		
			End If
			
			If Not lo_NFE.of_verifica_cancelamento(as_Chave_Acesso, ref as_mensagem_log) Then
				lb_Retorno = False
				Return False
			End If
			
			//Se for uma nota de entrada, o sistema automaticamente definir$$HEX1$$e100$$ENDHEX$$ o id_resolvido como "S".
			If lt_InfNFe.ide.tpnf = 0 Then
				as_Mensagem_Log = "Essa nota foi emitida como nota de entrada."
				as_Resolvido	= 'S'
				adt_resolvido	= gf_GetServerDate()
				lb_Retorno = False
				Return False
			End If
			
			//Se a nota foi emitida em homologa$$HEX2$$e700e300$$ENDHEX$$o, o sistema automaticamente definir$$HEX1$$e100$$ENDHEX$$ o id_resolvido como "S".
			if gvo_aplicacao.ivs_datasource <> 'homologa' then
				If lt_InfNFe.ide.tpamb = 2 Then
					as_Mensagem_Log = "Essa nota foi emitida em ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o."
					as_Resolvido	= 'S'
					adt_resolvido	= gf_GetServerDate()
					lb_Retorno = False
					Return False			
				End If
			end if
			
			//Verifica se o XML $$HEX1$$e900$$ENDHEX$$ de estorno
			If lt_InfNFe.ide.finnfe <> 1 Then
				If Not of_atualiza_finalidade_nfe(String(lt_InfNFe.ide.finnfe), as_Chave_Acesso, Ref as_Mensagem_Log ) Then
					lb_Retorno = False
					Return False
				End If
				
				Return False
			End If
			
			ls_nat_operacao = lt_InfNFe.ide.natOp
			
			If Mid(ls_nat_operacao, 1, 3) = "999" Then //Nota de estorno
				as_Mensagem_Log = ls_nat_operacao
				Return False
			End If
						
			ls_CNPJ_For	 = 	lt_InfNFe.emit.cnpj
			
			If ib_Grava_Agendamento Then
				lb_Retorno = False
				If of_insere_nf_agendamento(lt_InfNFe, as_chave_acesso, ref as_mensagem_log, ref as_Mensagem_PBM, al_filial, ab_envio_email  ) Then
					If of_atualiza_pedido_distribuidora (as_chave_acesso, ref as_mensagem_log) Then
						If of_insere_nf_agendamento_item(lt_InfNFe, as_chave_acesso, ref as_mensagem_log) Then
							If of_insere_nf_agendamento_titulo(lt_InfNFe, as_chave_acesso, ref as_mensagem_log) Then
								// Realiza o commit somente se o SAP ainda n$$HEX1$$e300$$ENDHEX$$o estiver rodando
								This.of_Executa_Commit()
								// SAP se tiver algum erro, retorna com erro e faz rollback
								If of_verifica_divergencias_agendamento( as_chave_acesso, adt_Emissao, ref as_mensagem_log) Then
									SqlCa.of_Commit();
									lb_Retorno = True
								End if
							End If
						End If
					End If
				End If
				
				If Not lb_Retorno  Then 
					If ib_Iniciado_Operacao_SAP Then SqlCa.of_Rollback()
					Return False
				End If				
			End If
			
			If Not ib_Iniciado_Operacao_SAP Then
				
				////////////////////////////////////////////////////////////////////////////////////
				SetNull(ivl_Pedido)
				ivs_Chave_Acesso = as_Chave_Acesso
				
				If of_Valida_Pedido(lt_InfNFe, Ref ivl_Pedido, Ref ls_Mensagem_Log) Then
					If Not of_Valida_Pedido_Ativo(ivl_Pedido, Ref ls_Mensagem_Log) Then
						If Not of_grava_divergencia(ls_Mensagem_Log, 12, "", "", Ref as_Mensagem_Log ) Then
							lb_Retorno = False
						End If
					End If
				Else	
					If of_Inclui_Pedido_PBM( lt_InfNFe, Ref ll_Pedido_PBM,  Ref as_Mensagem_PBM, as_chave_acesso, ref lb_Erro ) Then
						ivl_Pedido = ll_Pedido_PBM
					Else
						SqlCa.of_Rollback();
	
						If Not of_grava_divergencia( ls_Mensagem_Log, 12, "", "", Ref ls_Mensagem_Log ) Then
							as_Mensagem_Log = ls_Mensagem_Log
							lb_Retorno = False
							Return False
						End If
					End If
				End If
				
				// N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para enviar a chave de acesso
				If Not of_Valida_Cnpj_Fornecedor(lt_InfNFe.emit.cnpj, ivl_Pedido, Ref ls_Mensagem_Log, '') Then
					as_Mensagem_Log = ls_Mensagem_Log
					lb_Retorno = False
					Return False
				End If
				
				If Not of_Valida_Produtos_Pedidos(lt_InfNFe, ivl_Pedido, Ref ls_Mensagem_Log) Then
					as_Mensagem_Log = ls_Mensagem_Log
					lb_Retorno = False
					Return False	
				End If		
				
				lb_Sucesso = False
				
				// Grava o n$$HEX1$$fa00$$ENDHEX$$mero do pedido para gerar o relat$$HEX1$$f300$$ENDHEX$$rio lead time
				If This.of_Atualiza_Pedido_Central(Ref as_Mensagem_Log) Then 
					If This.of_atualiza_cabecalho_nfe_indexacao(lt_InfNFe, as_chave_acesso, ref as_Mensagem_Log) Then 
						If This.of_insere_item_nfe_indexacao(lt_InfNFe, as_chave_acesso, ref as_Mensagem_Log) Then
							lb_Sucesso = True
							SqlCa.of_Commit();
						End If
					End If
				End If
			
				If Not lb_Sucesso Then 
					lb_Retorno = False
					Return False
				End If
				
			End If
			////////////////////////////////////////////////////////////////////////////////////
		
		Finally
			Destroy lo_NFE
		End Try	
	
	Else
		as_Mensagem_Log =  "XML est$$HEX1$$e100$$ENDHEX$$ vazio"
		ib_marca_verificado_divergencia_ped = False 
		lb_Retorno = False
	End If
	
	//Verifica se houve divergencias
	If ((UpperBound(ivs_Divergencias[]) > 0) Or (UpperBound(ivs_Divergencias_Agend[]) > 0)) and &
		not lb_agendamento_liberado Then
		If ib_Grava_Agendamento Then
			ivs_Divergencias[] = ivs_Divergencias_Agend[]
		End If
		
		If gvo_Aplicacao.ivs_DataSource = 'central' Then
			If Not of_envia_email_divergencias_dll(ivl_Pedido, lt_InfNFe, as_Diretorio_Xml, Ref ls_Mensagem_Log, ai_log, True) Then
				This.of_Grava_Log(ai_log, "Erro ao enviar email pela DLL 'Eventos_Sefaz': "+ls_Mensagem_Log)
				//Envia e-mail do RO sen$$HEX1$$e300$$ENDHEX$$o conseguir enviar e-mail da forma antiga
				If Not ib_Grava_Agendamento Then
					If Not of_envia_email_divergencias(ivl_Pedido, lt_InfNFe, ls_Diretorio_Xml, Ref ls_Mensagem_Log) Then
						as_Mensagem_Log = ls_Mensagem_Log
						lb_Retorno = False
					End If
				End If
			End If
		End If
	End If

	//Divergencias que n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o enviadas para o fornecedor
	If UpperBound(ivs_Divergencias_Agend_Nao_Fornec[]) > 0 Then
		str = str_Limpar
		
		If ib_Grava_Agendamento Then
			ivs_Divergencias[] = ivs_Divergencias_Agend_Nao_Fornec[]
		End If
		
		If gvo_Aplicacao.ivs_DataSource = 'central' Then
			If Not of_envia_email_divergencias_dll(ivl_Pedido, lt_InfNFe, as_Diretorio_Xml, Ref ls_Mensagem_Log, ai_log, False) Then
				This.of_Grava_Log(ai_log, "Erro ao enviar email pela DLL 'Eventos_Sefaz': "+ls_Mensagem_Log)
				//Envia e-mail do RO sen$$HEX1$$e300$$ENDHEX$$o conseguir enviar e-mail da forma antiga
				If Not ib_Grava_Agendamento Then
					If Not of_envia_email_divergencias(ivl_Pedido, lt_InfNFe, ls_Diretorio_Xml, Ref ls_Mensagem_Log) Then
						as_Mensagem_Log = ls_Mensagem_Log
						lb_Retorno = False
					End If
				End If
			End If
		End If
	End If
Finally
	If lb_Retorno Then
		If ((UpperBound(ivs_Divergencias[]) = 0) And &
			(UpperBound(ivs_Divergencias_Agend_Nao_Fornec[]) = 0) And &
			(UpperBound(ivs_Divergencias_Agend[]) = 0)) or &
			lb_agendamento_liberado Then //Se passou por todas as valida$$HEX2$$e700f500$$ENDHEX$$es
			If Not Isnull(is_Recebimento_SAP) Then
				update recebimento_sap
					set id_situacao = 'P', 
						 dh_nf_agend_ent_integrada = getdate()
				 where nr_recebimento = :is_Recebimento_SAP
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SQLErrText
					SqlCa.of_RollBack()
					as_Mensagem_Log = "Erro ao liberar ao atualizar o registro na [RECEBIMENTO_SAP]: "+ ls_Erro
					Return False
				End If	
			End If
			
			//TRATAMENTO an$$HEX1$$e100$$ENDHEX$$lise de XML
			//Se houver diret$$HEX1$$f300$$ENDHEX$$rio definido no .INI o XML ser$$HEX1$$e100$$ENDHEX$$ movido
			If gvs_Dir_AnaliseXML <> "" Then
				lf_move_arquivo_xml_validacao(ls_Diretorio_Xml, as_chave_acesso, ref ls_Log_Validacao)
				If Not IsNull(ls_Log_Validacao) and Trim(ls_Log_Validacao) <> '' Then
					This.of_Grava_Log(ai_log, ls_Log_Validacao)
				End If
			End If
			
			//Aqui comita mesmo sem ter divergencias para acerto do agendamento
			SQLCA.of_commit()
		End If
	End If
	
	If FileExists(ls_Diretorio_Xml) Then FileDelete(ls_Diretorio_Xml)
	
	If Not ib_Iniciado_Operacao_SAP Then
		If ib_marca_verificado_divergencia_ped Then This.of_marca_verificado_divergencia_ped(as_chave_acesso, ai_log, as_index_destinadas)
	End If
	
	If ib_Pedido_Ba Then
		of_msg_logistica_exclu_ba(ai_log)
	End If
	
End Try

Return lb_Retorno
end function

public function boolean of_atualiza_pedido_distribuidora (string as_chave_acesso, ref string as_log);Update	pedido_distribuidora
	Set	id_situacao = 'F'
	From	pedido_distribuidora pd
	Inner Join	pedido_central pc
		On	pd.cd_filial = pc.cd_filial
		And	pd.nr_pedido_distribuidora = pc.nr_pedido_distribuidora
		And	pd.cd_distribuidora = pc.cd_fornecedor
	Inner join nf_agendamento_ent ne 
		On ne.nr_pedido_central = pc.nr_pedido
	Where ne.de_chave_acesso = :as_chave_acesso
Using	SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao localizar a chave de acesso do recebimento SAP. ' + SQLCA.SQLErrText
		Return False
End Choose

Return true
end function

public function boolean of_atualiza_pedido_central (ref string as_mensagem_log);Update nfe_indexacao
Set nr_pedido_central = :ivl_Pedido
Where id_nf = :ivs_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_mensagem_log = "Erro no insert do cabecalho pedido. " + SqlCa.SqlErrText
	SqlCa.of_RollBack()
	Return False
End If

Return True


end function

public function boolean of_atualiza_pedido_distribuidora_produto (long al_produto, long al_qt_faturada, string as_chave_acesso, ref string as_mensagem_log, long al_qt_embalagem_padrao_distrib);if IsNull(al_qt_embalagem_padrao_distrib) or al_qt_embalagem_padrao_distrib <= 0 then
	al_qt_embalagem_padrao_distrib	= 1
end if

If as_chave_acesso <> '' Then
	
	Update pedido_distribuidora_produto
		Set qt_faturada = :al_Qt_Faturada, 
			 id_situacao = 'F',
			 qt_embalagem_padrao_distrib	= :al_qt_embalagem_padrao_distrib
	From	pedido_distribuidora_produto pdp 
	Inner join 	pedido_distribuidora pd
		On pdp.cd_filial = pd.cd_filial 
		And pdp.nr_pedido_distribuidora = pd.nr_pedido_distribuidora
	Inner Join	pedido_central pc
		On	pd.cd_filial = pc.cd_filial
		And	pd.nr_pedido_distribuidora = pc.nr_pedido_distribuidora
		And	pd.cd_distribuidora = pc.cd_fornecedor
	Inner join nf_agendamento_ent ne 
		On ne.nr_pedido_central = pc.nr_pedido
	Where	ne.de_chave_acesso = :as_chave_acesso 
		And pdp.cd_produto = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Mensagem_Log = "Erro ao atualizar a tabela pedido_distribuidora_produto. " + SqlCa.SqlErrText
		SqlCa.of_Rollback()
		Return False
	End If	
	
Else	
	
	Update pedido_distribuidora_produto
		Set qt_faturada = :al_Qt_Faturada, 
			 id_situacao = 'F',
			 qt_embalagem_padrao_distrib	= :al_qt_embalagem_padrao_distrib
	 Where cd_filial = 534
		And nr_pedido_distribuidora = :il_Pedido_Distrib
		And cd_produto = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Mensagem_Log = "Erro ao atualizar a tabela pedido_distribuidora_produto. " + SqlCa.SqlErrText
		SqlCa.of_Rollback()
		Return False
	End If
							
End if
							
Return True
end function

on dc_uo_verifica_divergencia_notas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_verifica_divergencia_notas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ib_marreta_reposicao_sta = False
end event

event destructor;This.of_fecha_conexao_log()
end event

